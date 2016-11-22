class Screen
  def initialize
    @states = [ <<'STATE0', <<'STATE1', <<'STATE2', <<'STATE3', <<'STATE4', <<'STATE5', <<'STATE6' ]
+-----+
|     |
|
|
|
|
|
+-----------+
STATE0
+-----+
|     |
|    (x)
|
|
|
|
+-----------+
STATE1
+-----+
|     |
|    (x)
|     |
|     |
|
|
+-----------+
STATE2
+-----+
|     |
|    (x)
|    /|
|     |
|
|
+-----------+
STATE3
+-----+
|     |
|    (x)
|    /|\
|     |
|
|
+-----------+
STATE4
+-----+
|     |
|    (x)
|    /|\
|     |
|    /
|
+-----------+
STATE5
+-----+
|     |
|    (x)
|    /|\
|     |
|    / \
|
+-----------+
STATE6
  end

  # index is entirely based on the number of misses
  def get_state index
    @states[index]
  end

  # ask user for input (with or without a question)
  def ask_for_input question = nil
    write question if question

    print "> "
    gets.chomp
  end

  # helper method for writing to the console (in case we want to format the output)
  def write text
    puts text
  end
end
