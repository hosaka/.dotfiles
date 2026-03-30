if has delta
  set -gx GIT_PAGER "delta"
  set -gx DELTA_FEATURES "line-numbers navigate"
  # todo: not sure how to add interactive.diffFilter = delta --color-only
end

if has difft
  set -gx GIT_EXTERNAL_DIFF "difft --color=always"
end
