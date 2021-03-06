defmodule GodwokenExplorerWeb.API.BlockController do
  use GodwokenExplorerWeb, :controller

  import GodwokenRPC.Util, only: [stringify_and_unix_maps: 1]

  alias GodwokenExplorer.Block

  def show(conn, params) do
    block = Block.find_by_number_or_hash(params["id"])
    result = if is_nil(block) do
      %{
        error_code: 404,
        message: "not found"
      }
    else
      %{
          hash: block.hash,
          number: block.number,
          l1_block: block.layer1_block_number,
          tx_hash: block.layer1_tx_hash,
          finalize_state: block.status,
          tx_count: block.transaction_count,
          aggregator: block.aggregator_id,
          timestamp: block.timestamp
      } |> stringify_and_unix_maps()
    end

    json(
      conn,
      result
    )
  end
end
