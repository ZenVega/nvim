-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
-- Tell Treesitter to treat gql`` as GraphQL
vim.treesitter.language.register("graphql", "graphql")

-- Optional: also for ts/tsx/js files
vim.treesitter.query.add_predicate("is-gql", function(_, _, _, node)
  local text = vim.treesitter.get_node_text(node, 0)
  return text and text:match "^gql" ~= nil
end)
