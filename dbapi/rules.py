import re

import __importfix__; __package__ = 'dbapi'

from .__init__ import *

"""
letters_per_word
banned_words
max_num_words
forced_words
include_number_words


get_rules() --> returns a dictionary where the key is a rule_def_name and
                value is a description string

get_rules_params(story_id) --> returns a list of tuples
    with name and parameters of rules applied on that story_id [("name", "params"),...]

add_rule(story_id, rule_def_id, params) --> creates a new rule in the table "rules"
with the given data: story_id, rule_def_id, params.
"""

def list2str (data:list, separator:str='||'):
    """
This takes a list and inserts the separator in to return a string.
    """
    return separator.join(data)


def str2list (data:str, separator:str='||'):
    """.
This takes a list that is represented as a string with the given separator '||'.
And returns a list of strings.
    """
    return data.split(separator)


class Rules(object):

    def get_rules_params(story_id):
        cur = conn.cursor()
        cur.execute("""
SELECT d.name, r.params
FROM rules r
JOIN ruleDefs d ON r.rule_def_id = d.id
WHERE r.story_id = ?;""", (story_id,))
        rules = []
        for name, params in cur.fetchall():
            rules.append((name, str2list(params)))
        return rules

    def get_rules():
        cur = conn.cursor()
        cur.execute("""
SELECT *
FROM ruleDefs;""")
        rulesDict = {}
        for rule in cur.fetchall():
            rulesDict[rule[1]] = rule[2]
        return rulesDict

    def add_rule(story_id:int, rule_def_name:str, params:list):
        cur = conn.cursor()
        cur.execute("""
SELECT id
FROM ruleDefs
WHERE name = ?
""", (rule_def_name,))
        rule_def_id = cur.fetchone()[0]
        cur.execute("""
INSERT INTO rules (id, story_id, rule_def_id, params)
VALUES (NULL, ?, ?, ?)
""", (story_id, rule_def_id, list2str(params)))

    def letters_per_word(original:str, minimum:str, maximum:str):
        """
Returns False if the word is not within (or equal to) the minimum or maximum
values set by the user.
        """
        text = original.lower()
        eng_words = re.findall(r"[a-z'/-]+", text)        
        for word in eng_words:
            if not int(minimum) <= len(word) <= int(maximum):
                return False
        return True

    def banned_words(original:str, *banned_words:str):
        """
Returns False if a banned word is found within the text.
        """
        for word in banned_words:
            if re.search(r"\b{}\b".format(word), original, flags=re.IGNORECASE):
                return False
        return True
    


    def max_num_words(original:str, limit:str):
        """
The number of words in submission must be <= host's input
        """
        words = original.split()
        if len(words) <= int(limit):
            return True
        else:
            return False



    def forced_words(original:str, *forced_words:str):
        """
User's text must include the words host submits
        """
        for word in forced_words:
            if not re.search(r"\b{}\b".format(word), original, flags=re.IGNORECASE):
                return False
        return True

    def include_number_words(original:str, required_word:str, number:str):
        """
host sets requirement for certain word to be used in writers submission
every ___ words
        """
        words = original.split()
        count = 0
        number = int(number)
        for word in words:
            if word == required_word:
                count = 0
            else:
                count += 1
            if count >= number:
                return False
        return True

    def check(original:str, story_id:int):
        #get the list of rules for that story
        rows = Rules.get_rules_params(story_id)
        #rows = [ ('banned_words', "cat||dog||mouse"),
         #        ('letters_per_word', "3||4") ]
        #iterate of the list of rules, checking each
        for method, params in rows:
            if not eval("Rules.{}({},'{}')".format(
                method, repr(original), "','".join(params))):
                return False

        return True


if __name__=="__main__":
    
    #these are tests for this function

    assert not Rules.letters_per_word("cat it's", 0, 3)
    assert Rules.letters_per_word("c-d", 3, 999)
    assert Rules.letters_per_word("", 2, 999)

    assert Rules.banned_words("cation, organic", 'cat', 'gan')
    assert not Rules.banned_words("cat's, organic", 'cat', 'gan')
    assert Rules.banned_words("fjkalsd")
    assert not Rules.banned_words("blah blah blah", 'abc', 'blah')

    """ assert Rules.max_num_words("hello", 5)
    assert not Rules.max_num_words("hello hello hello", 2)
    assert Rules.max_num_words("hello hello", 2)
    assert Rules.max_num_words("", 3)
    assert not Rules.max_num_words("hello blah", -3)
    """

    assert not Rules.forced_words("banana", "c")
    assert Rules.forced_words("hello banana apple", "apple")
    assert not Rules.forced_words("hello banana apple", "ban")
    assert Rules.forced_words("hello banana apple", "")
    assert Rules.forced_words("hello banana apple", "hello", "banana")
    assert not Rules.forced_words("hello banana apple", "hello", "train")
    assert Rules.forced_words("hello banana apple", "hello", "apple")

    assert Rules.check("hello world", 0)

    #Rules.add_rule(0, 3, "100")

    #print(Rules.get_rules())
    #print(Rules.get_rules_params(0))
    assert type({}) == type(Rules.get_rules())

    #need to fix method so this assert passes
    assert Rules.forced_words("cats.", "cats")
