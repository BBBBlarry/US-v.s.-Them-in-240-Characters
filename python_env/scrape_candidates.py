pywikibot_dir = "./library/pywikibot/"

import os
os.environ["PYWIKIBOT_DIR"] = pywikibot_dir
os.environ["LANG"]="en_US.UTF-8"
os.environ["LC_ALL"]="en_US.UTF-8"

import json
import pywikibot
import mwparserfromhell as wiki_parser
from nltk.tokenize import RegexpTokenizer


def get_page_content(page_name):
    site = pywikibot.Site('en', 'wikipedia')
    page = pywikibot.Page(site, page_name)
    return page.text


def get_table_from_content(content):
    wikicode = wiki_parser.parse(content)
    summary = wikicode.get_sections(matches="Race summary")[0]
    state_summary = summary.get_sections(matches="States")[0]
    table = state_summary.filter(matches="wikitable")[0]
    rows = table.contents.nodes
    return rows


def extract_status_from_cell(cell_text):
    """
    Extracts the candidates in the race from string.
    :return: a list of (candidate, party, elected)
    """
    tokenizer = RegexpTokenizer(".+?\(.+?\)")
    tokens = tokenizer.tokenize(cell_text)

    res = set()
    for token in tokens:
        token = token.strip()
        elected = token.startswith('√')
        if elected:
            token = token.strip('√').strip()
        # remove percentages
        if '%' in token:
            token = token.split('%')[1].strip()

        # extract name & party
        parts = token.split("(")
        party = parts[-1].strip()[:-1]
        candidate = parts[0].strip()
        res.add((candidate, party, elected))

    return res


def extract_results_from_table(rows):
    results = []
    for row in rows[1:]:
        cells = row.contents.nodes
        state = cells[0].contents.strip_code().strip()
        incumbent = cells[1].contents.strip_code().strip()
        candidates_cell = cells[4].contents.strip_code().strip()
        candidates = extract_status_from_cell(candidates_cell)

        for name, party, elected in candidates:
            incumbency = name == incumbent
            results.append({"name": name, "state": state, "party": party, "incumbency": incumbency, "elected": elected})

    return results


if __name__ == "__main__":
    content = get_page_content("2014_United_States_gubernatorial_elections")
    table = get_table_from_content(content)
    election = extract_results_from_table(table)

    with open("2014_us_gubernatorial_election_candidates.jsonlist", 'w') as f:
        for j in election:
            f.write(json.dumps(j) + "\n")

