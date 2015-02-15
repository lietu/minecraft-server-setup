include:
 - java
 - user
 - supervisor

{% set home = "/home/minecraft" %}

{{ home }}/backups:
  file.directory:
    - user: minecraft
    - group: minecraft
    - mode: 750
    - makedirs: True

{{ home }}/start.sh:
  file.managed:
    - source: salt://minecraft/start.sh
    - user: minecraft
    - group: minecraft
    - mode: 750

{{ home }}/create_backups.sh:
  file.managed:
    - source: salt://minecraft/create_backups.sh
    - user: minecraft
    - group: minecraft
    - mode: 750
  cron.present:
    - user: minecraft
    - minute: random
    - hour: 0,12

/etc/supervisor/conf.d/minecraft.conf:
  file.managed:
    - source: salt://minecraft/minecraft.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: supervisor
