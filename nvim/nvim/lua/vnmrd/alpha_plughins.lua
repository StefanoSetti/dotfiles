-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {pattern = "plugins.lua", command = "source <afile> | PackerSync", group=packer_user_config})


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  -- Packer can manage itself
  -- se messo qua l'autocomando sopra che aggiorna packer quando questo
  -- file viene modificato non crea problemi,altrimenti sì.
  use 'wbthomason/packer.nvim'

  -- questo plugin cozza un pochino con altre impostazioni di vim
  -- regex normali anziché di vim specifiche
  -- use 'othree/eregex.vim'
  --

  -- parla da se'
  --use 'lervag/vimtex'

  --plugin per l'albero delle cartelle sulla sinistra
  -- use 'preservim/nerdtree'

  -- lightline però carina scritta in lua con qualche cosina in più
  -- https://github.com/nvim-lualine/lualine.nvim
  -- lista dei temi disponibili https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
  use 'nvim-lualine/lualine.nvim'

  -- indentazione
  use 'lukas-reineke/indent-blankline.nvim'

  -- see markdown text preview in browser
  -- version vim-plug e packer
  -- use 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  use {'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'}

  ------------------------------------------------------------------------------
  -- TELESCOPE

  -- https://github.com/nvim-telescope/telescope.nvim
  -- telescope
  use 'nvim-telescope/telescope.nvim'
  -- dependencies for telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  -- extension for sorter in telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- extension for advanced file browser in telescope
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- zoxyde integration for telescope
  use 'jvgrootveld/telescope-zoxide'

  ------------------------------------------------------------------------------
  -- LSP, SINTASSI, FRAMMENTI, ETC.

  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- evidenziazioe sintassi fatta bene
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- parentesi colorate per appartenenza tramite sieditore albero
  use 'p00f/nvim-ts-rainbow'

  -- installatore servitori. tutto molto carino, integrato nella configurazione
  -- di lspconfig
  use 'williamboman/nvim-lsp-installer'

  -- componenente base per il servitore lsp
  use {'neovim/nvim-lspconfig',
    requires = { 'hrsh7th/nvim-cmp'},
  }


  -- snippet plugin. to be removed
  -- use 'SirVer/ultisnips'
  -- nuovo plugin per i frammenti, scritto in lua
  use 'L3MON4D3/LuaSnip'

  -- linters, sintassi... cose
  use 'jose-elias-alvarez/null-ls.nvim'

  -- firma della funziona con finestrella a comparsa molto utile
  use 'ray-x/lsp_signature.nvim'

  -- creare "modalità" fai da te con mappature modulabili
  -- use 'tjdevries/stackmap.nvim'

  ------------------------------------------------------------------------------
  -- NVIM-CMP

  -- componenenti per il completamento. il primo è il principale e gli altri sono
  -- estenioni
  use { 'hrsh7th/nvim-cmp',
    -- completamente da server di linguaggio, buffer attuale, da perscorso, da comandi (per la modalità
    -- comando, e per le ultisnips
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'ray-x/cmp-treesitter'},
      {'saadparwaiz1/cmp_luasnip'},
      { "dmitmel/cmp-cmdline-history" },
      -- {'quangnguyen30192/cmp-nvim-ultisnips'},
    },
  }

  -- riga dei buffer e delle schede che segue il tema di lualine
  -- use {'kdheepak/tabline.nvim',
  -- 	config = function()
  -- 		require'tabline'.setup{
  -- 			options = {
  -- 				show_tabs_always = false,
  -- 			}
  -- 		}
  -- 	end,
  -- 	requires = {{ 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true}}
  -- }

  -----------------------------------------------------------------------------
  -- NVIM-DAP

  -- componente principale
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'


  -----------------------------------------------------------------------------
  -- INTERFACCIA GRAFICA
    -- sia cose che migliorano altre funzioni dal punto di vista grafico, sia
    -- cose che migliorano funzioni interne di neovim

  -- non ho ancora capito cosa cazzo faccia
  -- ora sì: sostituisce quickfic e loclist per diagnosi lsp ed altri casi
  -- comodissimo
  use 'folke/trouble.nvim'

  -- migliorie per l'interfaccia dell'lsp
  -- use 'glepnir/lspsaga.nvim'
  -- use {'tami5/lspsaga.nvim',
  -- 	config = function() require('lspsaga').init_lsp_saga() end
  -- }

  -- icone carine nel menù completamento.
  -- per poter vedere le icone è necessario un carattere di tipo nerd installato
  -- di sistema ed impostato nel terminale
  use 'onsails/lspkind-nvim'

  -- schermata di benvenuto
  use 'goolord/alpha-nvim'

  -- notifiche carine. impostato nelle opzioni come gestore notifiche
  -- predefinito
  use 'rcarriga/nvim-notify'

  -- interfaccia grafica carina
  use 'stevearc/dressing.nvim'

  -- interfaccia grafica per le schede ed i buffer
  use 'romgrk/barbar.nvim'

  use 'kdheepak/tabline.nvim'

  -- interfaccia git mezza grafica
  use 'tanvirtin/vgit.nvim'

  -- finestrella in basso che mostra le scorciatoie disponibili
  use 'folke/which-key.nvim'
  -- coloratissimi schemi colore senza colore anche perché colora
  use 'folke/lsp-colors.nvim'

  -- terminale flottante
  use 'numToStr/FTerm.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons'},
    -- icone carine
    config = function() require('nvim-tree').setup{} end
  }

  -- icone richieste da molti componenenti
  use 'kyazdani42/nvim-web-devicons'

  -- barra laterale
  -- use 'sidebar-nvim/sidebar.nvim'

  -----------------------------------------------------------------------------
  -- VARIE UTILITÀ

  -- scorciatoie per i commenti
  use { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  }
  -- ros ros ros
  -- rallenta troppo l'avvio
  use {'taketwo/vim-ros',
    config = function ()
      require('user.lazy_load').vim_ros()
    end
  }

  -- integrazione con ROS
  use {'thibthib18/ros-nvim', config=function()
    require('ros-nvim').setup({}) end
  }

  -- plugin per allineare cose in tabella sulla base di una trama, usando il
  -- comando Tabularize e poi /trama
  use 'godlygeek/tabular'

  -- dividere la finestra aprendo un terminal in un colpo rapido
  -- use 'mklabs/split-term.vim'

  --per interagire con jupyter console
  use 'jupyter-vim/jupyter-vim'

  -----------------------------------------------------------------------------
  -- SCHEMI COLORE
  use 'morhetz/gruvbox'
  use 'eddyekofo94/gruvbox-flat.nvim'
  -- more gruvbox ( this one needs instructions)
  use 'sainnhe/gruvbox-material'

  use "savq/melange"
  use 'folke/tokyonight.nvim'
  use { 'embark-theme/vim', as = 'embark'}
  -- use { 'challenger-deep-theme/vim', as = 'challenger-deep' }
  use 'sainnhe/sonokai'
  use 'sainnhe/everforest'
  -- tema caruccio per la versione qt di neovim
  use 'joshdick/onedark.vim'
  use 'https://github.com/Domeee/mosel.nvim'
  -- schema con diverse varianti
  use({'catppuccin/nvim', as = 'catppuccin'})

  -----------------------------------------------------------------------------
  -- cosetta di PACKER
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
