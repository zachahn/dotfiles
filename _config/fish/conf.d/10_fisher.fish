if not functions -q fisher
  if not test -d $__fish_config_dir/functions
    mkdir $__fish_config_dir/functions
  end

  if type -q curl
    curl https://raw.githubusercontent.com/jorgebucaran/fisher/HEAD/functions/fisher.fish \
      -o $__fish_config_dir/functions/fisher.fish
    fish -c fisher
  end
end
