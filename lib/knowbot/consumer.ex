defmodule Knowbot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  @help_content ~S"""
  **KnowBot**: Your learning assistant. Like you, I'm getting smarter every day.

  Each command starts with \"**!**\" (the \"bang\" character [shift-1]).
  **!h** or **!help** - Gets you this help content.
  **!q** - Ask a question. EXAMPLES:
         !q How do I use Enum?
         !q Enum?
         !q Enum.filter?
      I start with the **?**. I assume the most important word has the question mark after it.
  **!faq** - show the Frequently Asked Questions (FAQs).
  """
  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    # IO.inspect(msg.content, label: "handle_event")
    # cond do
    #   ...>   2 + 2 == 5 ->
    #   ...>     "This is never true"
    #   ...>   2 * 2 == 3 ->
    #   ...>     "Nor this"
    #   ...>   true ->
    #   ...>     "This is always true (equivalent to else)"
    #   ...> end
    # String.downcase(msg.content) |> case msg_content do
    msg_content = String.downcase(msg.content)
    # case String.downcase(msg.content) do
    cond do
      #  String.starts_with(msg_content, "!q") -> # ... the rest is search_phrase
      #   search_term =
      #     msg_content
      #     |> String.split
      #     |> Enum.filter(fn word -> String.ends_with?(word, "?") end)
      #     |> List.first
      #     |> String.trim_trailing("?")
      #   # search_results = search_by(search_term)
      #   |> Api.create_message(msg.channel_id)

      msg_content == "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        # This won't stop other events from being handled.
        Process.sleep(3000)

      msg_content == "!ping" ->
        Api.create_message(msg.channel_id, "Hello DY Academy! I am your KnowBot.")

      # msg_content == "!h" ->
      #   Api.create_message(msg.channel_id, @help_content)
      #   user = userManager.GetCurrentUser()
      #   Console.WriteLine("Connected to user {0}", user.Id);

      msg_content == "!help" ->
        Api.create_message(msg.channel_id, @help_content)

      msg_content == "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      # _ -> # FOR CASE STATEMENT ONLY
      true ->
        :ignore
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
