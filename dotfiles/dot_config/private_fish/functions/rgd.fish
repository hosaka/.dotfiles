if has rg
  if has delta
    function rgd -d 'ripgrep with syntax highlight using delta'
      rg --json --context 2 "$argv" | delta
    end
  end
end

