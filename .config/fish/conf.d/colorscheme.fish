# # Dracula Color Palette
# set -l foreground f8f8f2
# set -l selection 44475a
# set -l comment 6272a4
# set -l red ff5555
# set -l orange ffb86c
# set -l yellow f1fa8c
# set -l green 50fa7b
# set -l purple bd93f9
# set -l cyan 8be9fd
# set -l pink ff79c6

# Gruvbox Color Palette
# You can see this palette here: https://camo.githubusercontent.com/72015eab40bd7a696e2802810d7519480d51a2fba75f0f873dc23b990eb860f8/687474703a2f2f692e696d6775722e636f6d2f776136363678672e706e67
set -l foreground a89984
set -l selection 504945
set -l comment 665c54
set -l red cc241d
set -l orange d65d0e
set -l yellow d79921
set -l green 98971a
set -l purple b16286
set -l cyan 689d6a # aqua
set -l blue 458588

# Syntax Highlighting Colors
set -gx fish_color_normal $foreground
set -gx fish_color_command $cyan
set -gx fish_color_keyword $pink
set -gx fish_color_quote $yellow
set -gx fish_color_redirection $foreground
set -gx fish_color_end $orange
set -gx fish_color_error $red
set -gx fish_color_param $purple
set -gx fish_color_comment $comment
set -gx fish_color_selection --background=$selection
set -gx fish_color_search_match --background=$selection
set -gx fish_color_operator $green
set -gx fish_color_escape $pink
set -gx fish_color_autosuggestion $comment
set -gx fish_color_cancel $red --reverse
set -gx fish_color_option $orange

# Default Prompt Colors
set -gx fish_color_cwd $green
set -gx fish_color_host $purple
set -gx fish_color_host_remote $purple
set -gx fish_color_user $cyan

# Completion Pager Colors
set -gx fish_pager_color_progress $comment
set -gx fish_pager_color_background
set -gx fish_pager_color_prefix $cyan
set -gx fish_pager_color_completion $foreground
set -gx fish_pager_color_description $comment
set -gx fish_pager_color_selected_background --background=$selection
set -gx fish_pager_color_selected_prefix $cyan
set -gx fish_pager_color_selected_completion $foreground
set -gx fish_pager_color_selected_description $comment
set -gx fish_pager_color_secondary_background
set -gx fish_pager_color_secondary_prefix $cyan
set -gx fish_pager_color_secondary_completion $foreground
set -gx fish_pager_color_secondary_description $comment
