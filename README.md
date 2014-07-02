# dcp Chef Recipe

Installs and configures my dotfiles and configuration standards for an Ubuntu box. Opinionated as it gets.

## Supported Platforms

* Ubuntu

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dcp']['user']</tt></td>
    <td>String</td>
    <td>User for whom to install dotfiles</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Usage

### dcp

Include `dcp` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[dcp]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

License:: MIT
Author:: Dan Poggi (dan.poggi@gmail.com)
