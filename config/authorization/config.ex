alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec.Constraint.ResourceFormat, as: ResourceFormatConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do

  defp authenticated_access() do
    %AccessByQuery{
      vars: [],
      query: "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      SELECT ?account WHERE {
          <SESSION_ID> session:account ?account .
      } LIMIT 1"
    }
  end

  defp has_group_access(group_uri) do
    %AccessByQuery{
      vars: [],
      query: "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      SELECT ?account WHERE {
          <SESSION_ID> session:account ?account .
          ?user foaf:account ?account ; foaf:member <#{group_uri}> .
      } LIMIT 1"
    }
  end

  def user_groups do
    [
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{},
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/public",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://data.rollvolet.be/vocabularies/pricing/VatRate",
                "http://data.rollvolet.be/vocabularies/crm/PostalCode",
                "http://schema.org/Country",
                "http://schema.org/Language",
                "http://www.w3.org/2006/vcard/ns#TelephoneType",
                "http://www.w3.org/2004/02/skos/core#Concept",
                "http://www.w3.org/2004/02/skos/core#ConceptScheme"
              ]
            }
          }
        ]
      },

      %GroupSpec{
        name: "rollvolet-write",
        useage: [:read, :write, :read_for_write],
        access: authenticated_access(),
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/rollvolet",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://www.w3.org/2006/vcard/ns#VCard",
                "https://data.vlaanderen.be/ns/gebouw#Gebouw",
                "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#Contact",
                "http://www.w3.org/2006/vcard/ns#Address",
                "http://www.w3.org/2006/vcard/ns#Email",
                "http://www.w3.org/2006/vcard/ns#Telephone",
                "http://data.rollvolet.be/vocabularies/crm/Intervention",
                "http://data.rollvolet.be/vocabularies/crm/Request",
                "http://schema.org/Offer",
                "http://data.rollvolet.be/vocabularies/crm/Offerline",
                "http://data.rollvolet.be/vocabularies/crm/CalculationLine",
                "https://purl.org/p2p-o/document#PurchaseOrder",
                "https://purl.org/p2p-o/invoice#E-FinalInvoice",
                "https://purl.org/p2p-o/invoice#E-PrePaymentInvoice",
                "https://purl.org/p2p-o/document#E-Invoice",
                "http://data.rollvolet.be/vocabularies/crm/Invoiceline",
                "http://data.rollvolet.be/vocabularies/crm/TechnicalWork",
                "http://data.rollvolet.be/vocabularies/crm/CustomerSnapshot",
                "http://data.rollvolet.be/vocabularies/crm/ContactSnapshot",
                "http://data.rollvolet.be/vocabularies/crm/BuildingSnapshot",
                "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
                "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#RemoteDataObject",
                "https://data.vlaanderen.be/ns/dossier#Dossier",
                "https://data.vlaanderen.be/ns/generiek#GestructureerdeIdentificator",
                "http://www.semanticdesktop.org/ontologies/2007/04/02/ncal#Calendar",
                "http://www.semanticdesktop.org/ontologies/2007/04/02/ncal#Event",
                "http://data.rollvolet.be/vocabularies/crm/AccountancyExport",
                "http://www.w3.org/ns/prov#Activity"
              ]
            }
          }
        ]
      },

      %GroupSpec{
        name: "rollvolet-read",
        useage: [:read, :read_for_write],
        access: authenticated_access(),
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/rollvolet",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://www.w3.org/ns/person#Person" # employees
              ]
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/users",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://xmlns.com/foaf/0.1/Person", # users
                "http://xmlns.com/foaf/0.1/OnlineAccount",
                "http://xmlns.com/foaf/0.1/Group"
              ]
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/sessions",
            constraint: %ResourceFormatConstraint{
              resource_prefix: "http://mu.semte.ch/sessions/"
            }
          }
        ]
      },

      # %GroupSpec{
      #   name: "board-write",
      #   useage: [:write],
      #   access: has_group_access("http://data.rollvolet.be/user-groups/board"),
      #   graphs: [
      #   ]
      # },

      %GroupSpec{
        name: "admin-write",
        useage: [:write],
        access: has_group_access("http://data.rollvolet.be/user-groups/admin"),
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/rollvolet",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://www.w3.org/ns/person#Person" # employees
              ]
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/users",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://xmlns.com/foaf/0.1/Person", # users
                "http://xmlns.com/foaf/0.1/OnlineAccount",
                "http://xmlns.com/foaf/0.1/Group"
              ]
            }
          }
        ]
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
