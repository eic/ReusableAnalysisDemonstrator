"""cardio -- example datacard processing

A simple module to facilitate processing datacards
during a snakemake workflow.

Attributes:
    Card (class): wrapper class to hold and access
        data from loaded datacard
    load_card (function): instantiate a Card
        object from datacard at provided path
    make_card (function): create a datacard
        based on a provided template and
        instantiate Card object from it

Todo:
    - [] Card
      - [x] Create
      - [x] Dump files
      - [] Dump commands
    - [x] Load card
    - [x] Create card
"""
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict
import datetime
import os
import yaml


@dataclass
class Card:
    """
    A simple wrapper class to hold data loaded
    from an input data card

    Attributes:
        data: data from the datacard

    Interface:
        dump_files:    dump filepaths to a list
        dump_commands: dump commands to bash scripts
    """
    data: Dict[str, Any] = field(default_factory=dict)

    def __init__(self, path: str = None):
        """
        Initialize with a card at `path`.

        Arguments:
            path: path to card
        """
        if path is not None:
            with open(Path(path), 'r') as card:
                self.data = yaml.safe_load(card)

    def __getitem__(self, key: str) -> Any:
        """
        Get card data at 'key'.
        """
        return self.data[key]

    def create(self, name: str) -> None:
        """
        Create a datacard at 'name' and dump
        data to it.

        Attributes:
            name: path to datacard
        """
        card_data = self.data

        # tabulate all files in 'location'
        card_data['files'] = list()
        for content in Path(card_data['location']).rglob("*"):
            if content.is_file():
                card_data['files'].append(str(content))

        # add timestamp and dump to output card
        card_data['timestamp'] = str(datetime.datetime.now())
        with open(Path(name), 'w') as card:
            yaml.dump(self.data, card)

    def dump_files(self, name: str, protocol: str = None) -> None:
        """
        Dump files to a list at 'name'. If
        protocol is 'rucio', will query file
        catalog based on `identifier`.
        """
        os.makedirs(os.path.dirname(name), exist_ok=True)
        if protocol == "rucio":
            rucio_did = self.data["identifier"]
            os.system(f"rucio replica list file --protocols root --pfns --rses isopenaccess {rucio_did} > {name}")
        else:
            with open (Path(name), 'w') as files:
                for file in self.data["files"]:
                    files.write(file + "\n")
        return

    def dump_commands(self, tag: str = None) -> None:
        """
        Dump commands for each rule to shell
        scripts. Will append 'tag' to name
        if not None.
        """
        # TODO
        return


def load_card(path: str) -> Card:
    """
    Load a datacard at 'path'.

    Arguments:
        path: path to the card to load
    """
    return Card(path)


def make_card(path: str, temp: str) -> Card:
    """
    Make a datacard at 'path' based
    on template at 'temp'.

    Arguments:
       path: path to card to make
       temp: path to template card
    """
    output = Card(temp)
    output.create(path)
    return Card(path)
