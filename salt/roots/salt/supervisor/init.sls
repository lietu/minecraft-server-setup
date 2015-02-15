supervisor:
    pkg.installed:
      - name: supervisor
    service.running:
      - enable: True
