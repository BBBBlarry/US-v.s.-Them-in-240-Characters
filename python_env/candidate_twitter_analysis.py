from collections import Counter
import json

twitter_file = "./2014_us_gubernatorial_election_candidates_with_twitter.jsonlist"


def dict_most_common(d):
    return sorted([(k, v) for k, v in d.items()], key = lambda x: -x[1])


def print_kv(kv, name=None):
    if name:
        prepend = "\t"
        print("=== {} ===".format(name))
    else:
        prepend = ""

    for k, v in kv:
        print("{}{}: {}".format(prepend, k, v))


if __name__ == "__main__":
    candidates = []
    with open(twitter_file, 'r') as f:
        for j in f:
            candidates.append(json.loads(j))

    # total twitter adoption
    has_twitter = 0
    total_candidates = len(candidates)
    for c in candidates:
        if c["twitter"]:
            has_twitter += 1
    print("{} out of {} ({}%) candidates has Twitter account."
          .format(has_twitter, total_candidates, float(has_twitter) / float(total_candidates) * 100))
    print

    # twitter adoption by party
    candidates_third_agg = candidates[::]
    for i in range(len(candidates_third_agg)):
        p = candidates_third_agg[i]["party"]
        if p != "D" and p != "R":
            candidates_third_agg[i]["party"] = "T"

    party_twitter_counter = Counter()
    party_twitter_counter.update([c["party"] for c in candidates_third_agg if c["twitter"]])
    party_counter = Counter()
    party_counter.update([c["party"] for c in candidates_third_agg])
    has_twitter_by_party = {}
    for p, _ in party_counter.most_common():
        has_twitter_by_party[p] = 100 * float(party_twitter_counter[p]) / float(party_counter[p])
    print_kv(dict_most_common(has_twitter_by_party), name="Party Twitter Adoption (%)")