module OdkToSalesforce
  ##
  # The runner sets in motion the import process. It is fed a hash of child
  # items (leafs on the dependency hash) and recursively imports up the
  # dependencies tree.
  #
  # TODO: validate before calling parent.
  class Runner

    ##
    # Takes a relationships hash generated by Salesforce class
    def initialize relationships
      @relationships = relationships
      @rf = Restforce.new
    end

    # - data: hash of salesforce data to be imported in the form:
    #
    #   { object: { field: value, field_2: [value_1, value_2 ] } }
    def run(sf_object, data)
      node = @relationships[sf_object.to_sym]
      parent_objects = []
      constraints = data[node[:name].to_sym]

      # => Set the target object of this run
      current_object = SalesforceObjects::ImportObject.new(@rf, obj_name: node[:name], attributes: constraints)

      if create_parents_first?(node, data)
        puts "-> find or create parents for #{node[:name]}"

        # => Loop through each parent to see if it needs to be created
        node[:parents].each do |parent_node, value|

          # => Does the mapping have a the parent in it?
          if data.has_key?(parent_node)

            # => Run this again for the parent all the way up the top object
            # => This will return a single parent object
            parent_object = run(parent_node.to_s, data)

            # => Add the current object as a child of the parent
            parent_object.add_child(current_object)

            return current_object
          end
        end
      else
        # => Now we're at the top object!
        # => Find or create it
        puts "-> find or create #{node[:name]}"

        # => Return the target object
        return current_object
      end
    end

    private

    ##
    # Checks if to go up the tree or continue creating current element
    #
    # NOTE: the approach being used here is extremely naive: it will only
    # check if the mapping lists one of the object's parents, and proceed if
    # true. It is up to the user to not screw stuff up.
    def create_parents_first?(node, data)
      mapping_includes_parents = false
      has_parents = !node[:parents].empty?
      if has_parents
        node[:parents].each do |parent, value|
          if data.has_key?(parent)
            mapping_includes_parents = true
          end
        end
      end

      has_parents && mapping_includes_parents
    end
  end
end
