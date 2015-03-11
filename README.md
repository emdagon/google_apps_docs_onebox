# Google docs Onebox for Discourse

This plugin allows to embed any published document, spreadsheet, forms, and/or Presentation from Google Drive.

## Installation

As seen in a [how-to on meta.discourse.org](https://meta.discourse.org/t/advanced-troubleshooting-with-docker/15927#Example:%20Install%20a%20plugin), simply **add the plugin's repo url to your container's app.yml file**:

```yml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/discourse/docker_manager.git
          - git clone https://github.com/naveed-ahmad/google_docs_onebox.git
```
* Rebuild the container

```
cd /var/docker
git pull
./launcher rebuild app
```

## Screenshots
![Spreadsheet](https://dl-web.dropbox.com/get/gdocs_onebox/Selection_004.png?w=AABPa1RGNEmysyqLbDmYO13ihd-1Nk6rpzFnE0SF-gm5_Q&dl=1&_subject_uid=80055464)
## Troublshooting 
