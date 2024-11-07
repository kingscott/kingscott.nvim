return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    local logo = [[
              _.-~-.
             7''  Q..\
          _7         (_
        _7  _/    _q.  /
      _7 . ___  /VVvv-'_                                            .
    7/ / /~- \_\\      '-._     .-'                      /       //
   ./ ( /-~-/||'=.__  '::. '-~'' {             ___   /  //     ./{   _      ./{
   V   V-~-~| ||   __''_   ':::.   ''~-~.___.-'' _/  // / {_   /  {  / }    /   \
  VV/-~-~-|/ \ .'__'. '.    '::  _    _                   {_/        _   _      ''
  / /~~~~||VVV/ /  \ )  \       | | _(_)_ __   ___   ___  ___  ___ _| |_| |_   .::'
 / (~-~-~\\.-' /    \'   \::::. | |/ | | '_ \ / _ \ / __|/ __'/ _ |_   _   _|  :::'
/..\    /..\__/      '     '::: |   \| | | | | (_) )\  \  (__( ( ) )| | | |   ::'
vVVv    vVVv                 ': |_|\_|_|_| |_|\__' |____|\___,\___/ |_| |_|   ''
                                              .__| |
                                               \__/
    ]]

    dashboard.section.header.val = vim.split(logo, '\n')
    return dashboard
  end,
  config = function(_, dashboard)
    --local startify = require 'alpha.themes.startify'
    ---- available: devicons, mini, default is mini
    ---- if provider not loaded and enabled is true, it will try to use another provider
    --startify.file_icons.provider = 'devicons'
    require('alpha').setup(dashboard.opts)
  end,
}
