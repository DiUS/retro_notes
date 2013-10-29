for f in `git ls-files src/main/webapp/static|sed 's_^src/main/webapp__'`; do echo '<script type="text/ng-template" id="'$f'">'; cat "src/main/webapp$f"; echo '</script>'; done
