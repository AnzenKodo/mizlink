# MizLink

The link shorter made with Shell-Script and configure with YAML file.

## Getting Started
1. Fork this [repo](https://github.com/anzenkodo/mizlink) and clone it.
2. Edit the YAML file.
  - Example:
    ```yaml
    ...
    links:
      - name: my-website
        link: https://my-website-url.com
    ```
3. Run build file in your terminal.
  ```
  ./build.sh
  ```

### Using with GitHub Pages
MizLink is pre-configured to build website in GitHub Pages.
1. Fork this [repo](https://github.com/anzenkodo/mizlink) and clone it.
2. Go to settings section -> Code and automation -> Pages -> Build and deployment
   - Select **Source:** Deploy from branch.
   - Select **Branch:** gh-pages and click save.

## Build and Demo
- See build files in [gh-pages](https://github.com/AnzenKodo/mizlink/tree/gh-pages) branch.
- [Demo](https://anzenkodo.github.io/mizlink/)
