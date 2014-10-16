bash:
    pkg.latest

{% if grains['oscodename'] in ['saucy'] %}

install_ubuntu_trusty_bash:
  cmd.script:
    - name: salt://shellshock/install_ubuntu_trusty_bash.sh
    - onlyif: env x='() { :;}; echo vulnerable' bash -c ":" | grep vulnerable
    - require:
      - pkg: bash

{% else %}

# only compiles if still vulnerable (OS pkg.latest above has no patch)
# TODO require build-essential and bison only if vulnerable pre-compile
compile_bash:
  cmd.script:
    - name: salt://shellshock/compile_bash.sh
    - cwd: /usr/src/
    - onlyif: env x='() { :;}; echo vulnerable' bash -c ":" | grep vulnerable
    - require:
      - pkg: bash

{% endif %}
