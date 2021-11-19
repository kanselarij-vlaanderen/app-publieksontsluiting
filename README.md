# Valvas

App that publishes all news items about decisions of the Flemish Government.

## Running the application

```
docker-compose up
```

The stack is built starting from [mu-project](https://github.com/mu-semtech/mu-project).

## Maintenance

### Themis data

Updating this stack to add the latest [Themis](https://themis.vlaanderen.be) data is currently a manual process.
- remove old Themis data (RDF types of the different entities contained within Themis can be found [here](https://github.com/kanselarij-vlaanderen/app-themis/blob/c674a86e24bc6647e61c2d760a8cff38a8059ca0/scripts/get_minister_dataset.sparql))
- add the new distribution (ttl-file) of the [Themis "Samenstelling Vlaamse Regering"-dataset](https://themis.vlaanderen.be/id/dataset/96be5ff2-3571-475f-96ac-fdbf8d364a94) by means of a migration.
- Make sure that all mandatees still have their valvas-specific title. If not, this title can be generated be means of the query in `./queries/mandatee-valvas-title.sparql`.
