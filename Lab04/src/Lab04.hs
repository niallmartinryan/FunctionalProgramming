{- FORENAME SURNAME STUDENT-ID -}

module Lab04 where
import BinTree
import System.IO

thisIsLab04 = "This is Lab 4"

{- 

Lab 04 implements a REPL that allows
the user to maintain and build a simple database
that records insured items: a description string along with their valuation.

The REPL provides facilites to add items, display them
and keeps a running total of the value of everything listed

When the REPL exists, it returns the running total

-}
type State
  = ( BinTree String Float  -- database
    , Float )               -- total valuation

{- Task 1 ======= (1 mark)

The prompt string should display the running total (somewhere)

-}
prompt04 hout state = hPutStr hout $ mkprompt state
mkprompt (binTree, x) = show x 

{- Task 2 ======= (2 marks)

The user should enter the command "exit" to exit.

-}
done04 command | command == "exit" = True
                 | otherwise  = False

{- Task 3 ======= (1 mark)

  The running total should be returned on exit

-}
exit04 (binTree, x) = return x

{- Tasks 4.1--4.5 ====== (16 marks)

  All commands are single lowercase words

  Task 4.1 ----- (4 marks)
   command "add" will issue two prompts, one to get the description, the second to get the value.
   The tree will have this information inserted into it,
   and the running total updated appropriately.

   use 'hGetLine handle' rather than 'getLine' !

   hint: to convert a string  'str' to a float 'f' use  f = read str :: Float
   This will give a runtime  error if the string does not represetn a float.
   All tests will use strings that do represent a float

  
  Task 4.2 ---- (4 marks)
   command "fix" will compute the total in the database tree
   and compare to the running total.
   If different it will issue a warning, and then fix it.
   If not different, it will silently return to the user prompt

   command "_zero",  already implemented, will set total to zero but leave tree untouched

  Task 4.3 ---- (4 marks)
   command "remove" will issue one prompt to get a description.
   It will remove the item by setting its value to zero,
   and correcting the running total

  Task 4.4 ---- (2 marks)
   command "list" will list each entry, one per line,
   in the form 'description value'

  Task 4.5 ---- (2 marks)
   command "?" will list all the commands on one line, except for _zero

-}

-- Ignore empty command lines
execute04 hin hout "" state = return state 

execute04 hin hout "add" (tree, total) = do hPutStr hout "What is the description "
                                            descrip <- hGetLine hin
                                            hPutStrLn hout "What is the value"
                                            val <- hGetLine hin
                                            let new = read val :: Float
                                            case treeLookup descrip tree of
                                                             Just prevVal -> return (treeInsert descrip new tree ,total-prevVal+new)
                                                             Nothing -> return (treeInsert descrip new tree, total + new)

-- execute04 hin hout "fix" (tree, total) = do if treeCount False tree == total then return (tree, 0)
--                                             else return (tree,(treeCount False tree ))


execute04 hin hout "remove" (tree, total) = do hPutStr hout "Please provide a description"
                                               descrip <- hGetLine hin
                                               case treeLookup descrip tree of
                                                             Just prevVal -> return (treeInsert descrip 0 tree ,total-prevVal+0)
                                                             Nothing -> return (treeInsert descrip 0 tree, total + 0)

execute04 hin hout "list" (tree, total) = do hPutStrLn hout (treeShowDatum False tree)
                                             return (tree, total)

execute04 hin hout "?" (tree, total) = do hPutStrLn hout "?"
                                          hPutStrLn hout "add"
                                          hPutStrLn hout "exit"
                                          hPutStrLn hout "fix"
                                          hPutStrLn hout "list"
                                          hPutStrLn hout "remove"
                                          return (tree, total)


-- if all above fail, then report unknown command error to user
execute04 hin   hout command state
 = do hPutStr   hout "Command '"
      hPutStr   hout command
      hPutStrLn hout "' not recognised!"
      return state

-- treeCount :: Bool -> BinTree k d -> Float
-- treeCount _ Empty = 0.0
-- treeCount False (Leaf k d) = d 
-- treeCount True (Leaf k d) = d
-- treeCount False (Branch (x) k d (y)) =treeCount True (x) + d +treeCount True (y)
-- treeCount True (Branch (x) k d (y)) =treeCount True (x) +d + treeCount True (y)


