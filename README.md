# docker

Install and Configure Docker

## Usage

```ruby
class{'docker':
}
```

## Development

For a local development environment you would need to setup:

* ruby (use rvm)
* vagrant
* virtualbox

```bash
# clone this repository
git clone https://github.com/jmangt/jmangt-docker.git

# install development depedencies
cd ~/jmangt-docker
bundle install

# run class specs
rake spec

# run acceptance specs
rake beaker
```

## Compatibility

* Centos 7.0 x64

## Depedencies
All the depedendencies are listed under [Puppetfile](https://github.com/jmangt/jmangt-docker.git/blob/master/Puppetfile)
