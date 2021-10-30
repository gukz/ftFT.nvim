#### NeoVim f|t|F|T<char> with buffer safe highlight

#### add below codes to your plugin config

``` lua
    ...
    { "some other plugin name" },
    
    { "gukz/ftFT.nvim" },
    
    { "some other plugin name" },
    ...
```

#### map to default f t F T or your own favourite keys
```
nnoremap f <cmd>lua require('ftFT').execute('f')<CR>
nnoremap t <cmd>lua require('ftFT').execute('t')<CR>
nnoremap F <cmd>lua require('ftFT').execute('F')<CR>
nnoremap T <cmd>lua require('ftFT').execute('T')<CR>

vnoremap f <cmd>lua require('ftFT').execute('f')<CR>
vnoremap t <cmd>lua require('ftFT').execute('t')<CR>
vnoremap F <cmd>lua require('ftFT').execute('F')<CR>
vnoremap T <cmd>lua require('ftFT').execute('T')<CR>
```

#### use f|t|F|T<char>, you will see different things, enjoy it!

[image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)
