return {
  'nvim-mini/mini.ai',
  version = '*' ,
  config = function (_, _)
    require('mini.ai').setup()
  end
}
