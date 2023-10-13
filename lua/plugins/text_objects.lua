return {
  'kana/vim-textobj-user',
  {'kana/vim-textobj-entire', dependencies = {'kana/vim-textobj-user'}},      --ae/ie for entire file
  {'kana/vim-textobj-indent', dependencies = {'kana/vim-textobj-user'}},      --ai/ii for indent block
  {'kana/vim-textobj-line', dependencies = {'kana/vim-textobj-user'}},        --al/il for line
  {'sgur/vim-textobj-parameter', dependencies = {'kana/vim-textobj-user'}},   --a,/i, for argument/parameter
  {'aoswalt/vim-textobj-elixir', dependencies = {'kana/vim-textobj-user'}},   --aE/iE for Elixir blocks as remapped
  {'Julian/vim-textobj-variable-segment', dependencies = {'kana/vim-textobj-user'}},    --av/iv for variable part
  {'Chun-Yang/vim-textobj-chunk', dependencies = {'kana/vim-textobj-user'}},  --ac/ic for json-ish chunk
  {'whatyouhide/vim-textobj-xmlattr', dependencies = {'kana/vim-textobj-user'}},  --ax/ix for xml attribute
}
