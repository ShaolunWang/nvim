[{1 :p00f/clangd_extensions.nvim
  :config 
  	(fn []
    	((. (require :clangd_extensions) :setup) 
			 {:extensions 
			 	{:ast
					{:highlights {:detail :Comment}
            	:kind_icons {:Compound ""
                :PackExpansion "" :Recovery "" 
								:TemplateParamObject "" :TemplateTemplateParm ""
                :TemplateTypeParm "" :TranslationUnit ""}
					:role_icons 
						{:declaration "" :expression ""
						:specifier "" 
						:statement "" "template argument"
						"" :type ""}}
        :autoSetHints true
                :inlay_hints 
				{:highlight :Comment :max_len_align false
                :max_len_align_padding 1
                :only_current_line false
                :only_current_line_autocmd :CursorHold
                :other_hints_prefix "=> "
                :parameter_hints_prefix "<- "
                :priority 100
                :right_align false
                :right_align_padding 7
                :show_parameter_hints true}
                :memory_usage {:border :none}
                :symbol_info {:border :none}}
			}))
  :ft [:cpp :h]}
{1
  :mrcjkb/rustaceanvim
  :version "^3"
  :ft  "rust"
}]
