def install_librarian(host)
  install_package host, 'ruby-dev'
  install_package host, 'make'
  install_package host, 'git-core'
  on host, 'if ! gem list librarian-puppet -i; then gem install librarian-puppet --no-ri --no-rdoc; fi'
end

def librarian_install_modules(directory, module_name)
  hosts.each do |host|
    puppet_module_install(:source => directory, :module_name => module_name)

    on host, "cd #{host['distmoduledir']}/#{module_name} && librarian-puppet install --clean --verbose --path #{host['distmoduledir']}"

  end
end
