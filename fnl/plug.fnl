(local lazy (require :lazy))
((. (require :lazy) :setup) 
	:plugins  {:performance {:reset_packpath false}}
	:install {:colorscheme :kanagawa}
	)	
