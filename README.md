#### Pure lua plugin give f|t|F|T{char} __buffer safe__ highlights

#### Demo
use f|t|F|T{char}, you will see something different, enjoy it!

![image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)

#### add below codes to your plugin config
1. Packer
``` lua
    ...
    { "some other plugin name" },

    { "gukz/ftFT.nvim",
      config = function require("ftFT").setup() end
    },

    { "some other plugin name" },
    ...
```

#### default behavior and custom config
1. by default, ftFT will use `Search` highlight to display, you can custom it by set `ftFT_hl_group`, shown as below
``` lua
    { "gukz/ftFT.nvim",
      config = function
        vim.g.ftFT_hl_group = 'Todo' -- will use Todo highlitgt, default is Search

        require("ftFT").setup()  -- this will create default keymapping for you
      end
    },

```

2. by default, `require("ftFT").setup()` will create key binding for all `ftFT` in normal, visual and `yf,df,cf` mode, if you don't like this keymapping, you can disable part of them, shown as below
``` lua
    { "gukz/ftFT.nvim",
      config = function
        vim.g.ftFT_disable_keymap_n = 1  -- Will not create key binding for ftFT in normal mode
        vim.g.ftFT_disable_keymap_ydc = 1  -- Will not create key binding for [ydc][ftFT] in normal mode
        vim.g.ftFT_disable_keymap_v = 1  -- Will not create key binding for ftFT in visual mode

        require("ftFT").setup()  -- if you config like above, no keymapping will create for you
      end
    },
```

3. you can also do the keybinding yourself
``` vim
nnoremap f <cmd>lua require('ftFT').execute('f')<CR>
nnoremap t <cmd>lua require('ftFT').execute('t')<CR>
nnoremap F <cmd>lua require('ftFT').execute('F')<CR>
nnoremap T <cmd>lua require('ftFT').execute('T')<CR>

nnoremap df <cmd>lua require('ftFT').execute('df')<CR>
nnoremap yf <cmd>lua require('ftFT').execute('yf')<CR>
nnoremap cf <cmd>lua require('ftFT').execute('cf')<CR>
```
