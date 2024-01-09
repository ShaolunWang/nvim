{1 :nvim-neorg/neorg
 :build ":Neorg sync-parsers"
 :cmd [:Neorg]
 :config (fn []           
           ((. (require :neorg) :setup) {:load 
				{
					:core.concealer {:config {:icons { :todo {:on_hold {:icon "="}
														:undone {:icon " "}}}}}
					:core.defaults {}
					:core.dirman {:config {:workspaces {:notes "~/notes"}}}
					:core.journal {:config {:strategy :flat
											:workspace :Notes}}
					:core.looking-glass {}
					:core.qol.toc {}
					:core.qol.todo_items {}
				}}))
 :dependencies [:nvim-lua/plenary.nvim]
 :ft [:norg]}
