#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (c) 2025 Mike Marshall.  All Rights Reserved.
#
# I made this script with grok while conversing with it about
# fs/orangefs/orangefs-debugfs.c.
#
# FS QA Test generic/700
#
# Exhaustive test for OrangeFS (PVFS2) debugfs kernel-debug file:
# - Valid settings including single keywords, combinations, negations,
#   specials (none, all, verbose)
# - Invalid settings, mixtures with invalid, empty input
# - Potential overflow with excessively long inputs
#
# Assumes output order may vary, so sorts for comparisons where
# applicable.
#
. ./common/preamble
_begin_fstest auto quick debugfs

# Override the default cleanup function.
_cleanup()
{
    cd /
    echo "$original_mask" > $DEBUG_FILE 2>/dev/null # Restore original
    rm -f $tmp.*
}

# Import common functions.
. ./common/filter

DEBUG_FILE="/sys/kernel/debug/orangefs/kernel-debug"
HELP_FILE="/sys/kernel/debug/orangefs/debug-help"

_require_debugfs
_require_command "/usr/bin/cat" cat
_require_command "/usr/bin/echo" echo

# real QA test starts here
_supported_fs pvfs2

# Save original mask
original_mask=$($CAT_PROG $DEBUG_FILE)
echo "Original mask: $original_mask"

# Get list of keywords from help
help_content=$($CAT_PROG $HELP_FILE)

# Assume it's comma or space separated, normalize to space
keywords=$(echo "$help_content" | tr ',' ' ' | tr -s ' ' | \
    sed 's/^ //;s/ $//')
if [ -z "$keywords" ]; then
    _fail "Could not read keywords from $HELP_FILE"
fi

# Special keywords
specials="none all verbose"

# Regular keywords
regular_keywords=$(echo "$keywords" | sed 's/none //g; s/all //g; ' \
    's/verbose //g')
regular_array=($regular_keywords)

# Function to sort comma-separated string for comparison
sort_mask() {
    echo "$1" | tr ',' '\n' | sort | tr '\n' ',' | sed 's/,$//'
}

# Function to set mask and check
set_check() {
    local input="$1"
    local expected="$2"
    local should_fail="$3" # "fail" if expect failure
    local rc=0

    $ECHO_PROG "$input" > $DEBUG_FILE 2>&1
    rc=$?

    if [ "$should_fail" = "fail" ]; then
        if [ $rc -eq 0 ]; then
            _fail "Write '$input' succeeded but expected failure"
        fi
        return
    fi

    if [ $rc -ne 0 ]; then
        _fail "Write '$input' failed with code $rc"
    fi

    local actual=$($CAT_PROG $DEBUG_FILE)
    local sorted_actual=$(sort_mask "$actual")
    local sorted_expected=$(sort_mask "$expected")
    if [ "$sorted_actual" != "$sorted_expected" ]; then
        _fail "After '$input', expected '$sorted_expected' " \
              "but got '$sorted_actual'"
    fi
}

# Test specials
set_check "none" "none"

# For "all", assume readback is the comma separated regular keywords
full_list=$(echo "${regular_array[@]}" | tr ' ' ',' )
set_check "all" "$full_list"

# For "verbose", assume it's "verbose"; if it expands to a list,
# adjust expected accordingly or comment out if unsure
set_check "verbose" "verbose"

# Test single valid keywords
for kw in "${regular_array[@]}"; do
    set_check "$kw" "$kw"
done

# Test combinations
# Pick first 3
com1="${regular_array[0]},${regular_array[1]},${regular_array[2]}"
set_check "$com1" "$com1"

# Another
com2="${regular_array[3]},${regular_array[4]}"
set_check "$com2" "$com2"

# Test negation: set all, then negate one
set_check "all" "$full_list"
neg1="-${regular_array[0]}"
exp1=$(echo "$full_list" | sed "s/${regular_array[0]},\{0,1\}//g")
set_check "$neg1" "$exp1"

# Another, negate two
set_check "all" "$full_list"
neg2="-${regular_array[0]},-${regular_array[1]}"
exp2=$(echo "$full_list" | sed "s/${regular_array[0]},\{0,1\}//g; " \
    "s/${regular_array[1]},\{0,1\}//g")
set_check "$neg2" "$exp2"

# Invalid
set_check "invalid" "" "fail"

# Mixed
set_check "${regular_array[0]},invalid" "" "fail"

# Duplicate
set_check "${regular_array[0]},${regular_array[0]}" "${regular_array[0]}"

# Empty
current=$($CAT_PROG $DEBUG_FILE)
echo "" > $DEBUG_FILE
if [ $? -ne 0 ]; then
    _fail "Empty write failed"
fi
actual=$($CAT_PROG $DEBUG_FILE)
if [ "$actual" != "$current" ]; then
    _fail "Empty write changed the mask"
fi

# Overflow
long=$(printf '%*s' 8192 'a')
set_check "$long" "" "fail"

long_comma=$(printf 'invalid,%*s' 8192 'invalid,' | cut -c1-8192)
set_check "$long_comma" "" "fail"

echo "All tests passed"
status=0
exit
