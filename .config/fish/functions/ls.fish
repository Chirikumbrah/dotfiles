function ls --wraps='eza --git -alb --icons --classify' --description 'alias ls=eza --git -alb --icons --classify'
  eza --git -alb --icons --classify $argv; 
end
