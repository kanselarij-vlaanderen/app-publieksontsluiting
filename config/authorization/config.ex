alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource.AllPredicates, as: AllPredicates
alias Acl.GraphSpec.Constraint.Resource.NoPredicates, as: NoPredicates
alias Acl.GraphSpec.Constraint.ResourceFormat, as: ResourceFormatConstraint
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  defp access_by_role( group_string ) do
    %AccessByQuery{
      vars: ["session_group"],
      query: sparql_query_for_access_role( group_string ) }
  end

  defp sparql_query_for_access_role( group_string ) do
    "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
    PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
    SELECT ?session_group ?session_role WHERE {
      <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                   ext:sessionRole ?session_role.
      FILTER( ?session_role = \"#{group_string}\" )
    } LIMIT 1"
  end

  defp named_graph_access_by_role( group_string, graph_name ) do
    %AccessByQuery{
      vars: ["name"],
      query: named_sparql_query_for_access_role( group_string, graph_name ) }
  end

  defp named_sparql_query_for_access_role( group_string, graph_name ) do
    "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
    PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
    SELECT ?name ?session_role WHERE {
      BIND(\"#{graph_name}\" AS ?name)
      <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                   ext:sessionRole ?session_role.
      FILTER( ?session_role IN (\"#{group_string}\") )
    } LIMIT 1"
  end

  defp direct_write_on_public( group_string ) do
    %AccessByQuery{
      vars: [],
      query: "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      SELECT ?session_role WHERE {
        <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                     ext:sessionRole ?session_role.
        FILTER( ?session_role IN (\"#{group_string}\") )
      } LIMIT 1" }
  end

  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{}, # TODO: Should be only for logged in users
        graphs: [ %GraphSpec{
          graph: "http://mu.semte.ch/graphs/public",
          constraint: %ResourceConstraint{
            resource_types: [
              "http://mu.semte.ch/vocabularies/ext/ThemaCode",
              "http://mu.semte.ch/vocabularies/ext/Thema",
              "http://data.vlaanderen.be/ns/besluitvorming#NieuwsbriefInfo",
              "http://data.vlaanderen.be/ns/mandaat#Mandataris",
              "http://www.w3.org/ns/person#Person",
              "http://data.vlaanderen.be/ns/besluitvorming#Agenda",
              "http://data.vlaanderen.be/ns/besluit#Agendapunt",
              "http://dbpedia.org/ontology/Case",
              "http://dbpedia.org/ontology/UnitOfWork",
              "http://data.vlaanderen.be/ns/besluit#Zitting",
              "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject"
            ]
          } } ]
      },
      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
