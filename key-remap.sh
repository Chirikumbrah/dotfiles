#!/bin/bash

# https://hidutil-generator.netlify.app

hidutil property --set '
{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0xC000000CF,
      "HIDKeyboardModifierMappingDst": 0x70000006B
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x10000009B,
      "HIDKeyboardModifierMappingDst": 0x70000006C
    }
  ]
}'

# hidutil property --get "UserKeyMapping"

# dictation      F16
# 0xC000000CF    0x700000068

# DND            F17
# 0x10000009B    0x70000006C
