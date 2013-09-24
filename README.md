# vps-digitalocean

A [Vagrant][1] + [Puppet][2] configuration to create [DigitalOcean][3] droplets for PHP development.

## Usage

Begin by placing your web files in the `files/www/` directory, so that they get uploaded when the
droplet is created.

Install the `gem` dependencies:

    bundle install

Generate the `Vagrantfile` by following the instructions:

    rake

Launch the DigitalOcean droplet:

    vagrant up --provider digital_ocean

## Used third-party libraries

* PuPHPet: [https://github.com/puphpet/puphpet][4]

## License

This package is licensed under the [MIT License][5] - see the LICENSE.txt file for more details.

[1]: http://docs.vagrantup.com/v2 "Vagrant Documentation"
[2]: http://docs.puppetlabs.com/ "Puppet Documentation"
[3]: https://www.digitalocean.com/?refcode=599f6048b45e "DigitalOcean Referral URL"
[4]: https://github.com/puphpet/puphpet "GitHub Repository"
[5]: http://opensource.org/licenses/mit-license.php "MIT License"
