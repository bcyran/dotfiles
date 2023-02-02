function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cp history-search-backward
        bind -M $mode \cn history-search-forward
        bind -M $mode \cy accept-autosuggestion
    end
end
