# CF Deploy MTA GitHub Action

This GitHub Action deploys a Multi-Target Application (MTA) to a Cloud Foundry environment on SAP BTP. It allows you to specify various configuration options through inputs and can also fetch the main application URL after deployment if configured.

## Inputs

Below are the inputs that you can configure for this action:

- `mtafile`: **Required**. The path to your MTA file, relative to the GitHub workspace.
- `api`: The Cloud Foundry API endpoint. Defaults to the environment variable `$CF_API`.
- `username`: The Cloud Foundry username. Defaults to the environment variable `$CF_USERNAME`.
- `password`: The Cloud Foundry password. Defaults to the environment variable `$CF_PASSWORD`.
- `org`: The Cloud Foundry organization. Defaults to the environment variable `$CF_ORG`.
- `space`: The Cloud Foundry space to deploy to. Defaults to the environment variable `$CF_SPACE`.
- `createspace`: Whether to create the given space. Default is `false`.
- `findurl_command`: A bash command used to determine the application's main URL.
- `findurl_regex`: A regex that scans the result of `findurl_command`. Default is `"https.*"`.

## Outputs

- `url`: The application's main URL, available only if `findurl_command` is set and successful.

## Usage

To use this action, add the following steps to your `.github/workflows` YAML file:

```yaml
steps:
- name: Checkout
  uses: actions/checkout@v2

- name: Deploy MTA
  uses: codeyogi911/btpcfdeploy@v1.0
  with:
    mtafile: 'path/to/your/mtafile'
    api: 'https://api.example.com'
    username: ${{ secrets.CF_USERNAME }}
    password: ${{ secrets.CF_PASSWORD }}
    org: 'example-org'
    space: 'example-space'
