handle_open = function do
  {:ok, file}  -> "First line: #{IO.readline(file)}"
  {_,   error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open.(File.open("myfile.txt")) 
IO.puts handle_open.(File.open("nonexistent")) 