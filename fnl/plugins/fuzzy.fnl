(local telescope_opts (fn []
	(let [options 
		   {:defaults 
		   		{:border {}
				  :borderchars {1 ["─"  "│" "─" "│" "┌" "┐" "┘" "└"]
								:preview ["─" "│" "─" "│" "┌" "┐" "┘" "└"]
								:prompt ["─" "│" " " "│" "┌" "┐" "│" "│"]
								:results ["─" "│" "─" "│" "├" "┤" "┘" "└"]}
				  :buffer_previewer_maker (. (require :telescope.previewers)
											 :buffer_previewer_maker)
				  :color_devicons true
				  :dynamic_preview_title true
				  :entry_prefix "  "
				  :file_previewer (. (. (require :telescope.previewers)
										:vim_buffer_cat)
									 :new)
				  :file_sorter (. (require :telescope.sorters)
								  :get_fuzzy_file)
				  :generic_sorter (. (require :telescope.sorters)
									 :get_generic_fuzzy_sorter)
				  :grep_previewer (. (. (require :telescope.previewers)
										:vim_buffer_vimgrep)
									 :new)
				  :initial_mode :insert
				  :layout_config {:horizontal {:height 0.8
											   :preview_cutoff 120
											   :preview_width 0.55
											   :prompt_position :top
											   :results_width 0.6
											   :width 0.87}
								  :vertical {:height 0.5
											 :prompt_position :top
											 :width 0.5}}
				  :path_display [:truncate]
				  :prompt_prefix "  "
				  :qflist_previewer (. (. (require :telescope.previewers)
										  :vim_buffer_qflist)
									   :new)
				  :selection_caret "❯ "
				  :selection_strategy :reset
				  :sorting_strategy :ascending
				  :vimgrep_arguments [:rg
									  :--color=never
									  :--no-heading
									  :--with-filename
									  :--line-number
									  :--column
									  :--smart-case
									  :--glob=!.git/]
				  :winblend 0}
				   :extensions {:fzf {:case_mode :smart_case
						:fuzzy true
						:override_file_sorter true
						:override_generic_sorter true}
						:ui-select [((. (require :telescope.themes)
						:get_dropdown))
						((. (require :telescope.themes) :get_ivy))]}
				   :pickers {:buffers {:initial_mode :normal
							:layout_strategy :vertical
						    :mappings {:n {:dd (. (require :telescope.actions)
												 :delete_buffer)}}
							:previewer false
							:prompt_position :telescope_opts
							:theme :ivy}
							:builtin {:layout_strategy :vertical
									   :previewer false
									   :prompt_position :top
									   :theme :ivy}
							:find_files {:layout_strategy :vertical
										  :previewer false
										  :prompt_position :top
										  :theme :ivy}
							:live_grep {}
							:oldfiles {:layout_strategy :vertical
										:previewer false
										:prompt_position :top
										:theme :ivy}}}
										]
	  options)))

(local telescope_setup
       (fn []
         (let [(present telescope) (pcall require :telescope)]
           (vim.cmd "    highlight TelescopePromptBorder guifg=#eeeeee      guibg=none     gui=none
    highlight TelescopeResultsBorder guifg=#eeeeee      guibg=none     gui=italic
    highlight TelescopePreviewBorder guifg=#eeeeee      guibg=none     gui=none
  ")
           (local options (telescope_opts))
           (telescope.setup options)
           (telescope.load_extension :ui-select)
           (telescope.load_extension :fzf))))

(var fuzzy {})
(if (not= (. (vim.loop.os_uname) :sysname) :Windows_NT)
    (set fuzzy [{1 :ibhagwan/fzf-lua
                 :cmd [:FzfLua]
                 :config (fn []
                           ((. (require :fzf-lua) :setup)
							{:files {:color_icons true
							   :fd_opts "--color=never --type f --hidden --follow --exclude .git"
							   :file_icons true
							   :git_icons true
							   :previewer :bat
							   :prompt "Files❯ "}
						   	   :winopts {:border false
									:fullscreen true
									:preview {:border :noborder
									   :default :bat_native
									   :layout :flex
									   :scrollbar false
									   :scrollchars ""}}})
                           ((. (require :fzf-lua) :register_ui_select)))
                 :dependencies [:nvim-tree/nvim-web-devicons]
                 :keys [:<leader>]}])
    (set fuzzy [{1 :nvim-telescope/telescope-fzf-native.nvim
                 :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
                 :lazy true}
                {1 :nvim-telescope/telescope.nvim
                 :cmd [:Telescope]
                 :config telescope_setup
                 :dependencies [:nvim-lua/plenary.nvim
                                :nvim-telescope/telescope-ui-select.nvim
                                :nvim-telescope/telescope-fzf-native.nvim]
                 :keys [:<leader>]
                 :lazy true}]))

fuzzy
