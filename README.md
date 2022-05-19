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
- add the new distribution (ttl-file) of the [Themis "Samenstelling Vlaamse Regering"-dataset](https://themis.vlaanderen.be/id/concept/dataset-type/43c644d3-2171-4892-8dd7-3fd5eec15d09) by means of a migration.
- Make sure that Valvas-specific extensions of Themis data are still working (see below)

#### Valvas-specific extensions of Themis data.
- The [Themis implementation](https://themis-test.vlaanderen.be/docs/catalogs) of the [mandaat](https://data.vlaanderen.be/ns/mandaat)-model provides in multiple mandatees for a single person in case this person holds multiple mandates, eg "minister" and "viceminister-president". In Valvas however, we want mandatees to be displayed with their "highest" title, regardless of the mandatee-entity related to an item. The query in `./queries/mandatee-valvas-title.sparql` generates a Valvas-specific title for each mandatee containing the "highest" mandate that the person related to multiple mandatees carries.
- For multiple meetings held at the same point in time (as is the case with regular "ministerraad" + "ministerraad - Plan Vlaamse Veerkracht"), the order in which these meetings are shown on Valvas is of importance. `./migrations/20211220134655-meeting-type-position.ttl` specifies this order by means of `schema:position`.