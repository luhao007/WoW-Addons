import os
import unittest
from pathlib import Path
from pprint import pprint

from toc import TOC
from utils import get_libraries_list


class CheckManagedAddOns(unittest.TestCase):

    def test_check_addon_toc(self):
        ignored = ['WA_sekiro']
        for addon in os.listdir('AddOns'):
            if addon in ignored:
                continue

            flavors = ['Mainline', 'Wrath', 'Cata', 'Classic']
            seps = ['-', '_']
            filenames = [f'{addon}.toc']
            filenames += [f'{addon}{sep}{flavor}.toc' for sep in seps for flavor in flavors]
            root = Path('AddOns') / addon
            self.assertTrue(any(os.path.exists(root/f'{f}') for f in filenames),
                            f"{addon}'s toc file not existed!")

    def test_check_libs(self):
        """Test for !!Libs.toc"""
        root = Path('AddOns/!!Libs')
        with open(root / '!!Libs.toc', 'r', encoding='utf-8') as file:
            lines = file.readlines()

        toc = TOC(lines)

        ignored = ['FrameXML', 'textures']
        # Check every lib folder exists in the toc
        for lib in os.listdir(root):
            if '.toc' not in lib and lib not in ignored:
                self.assertTrue(
                    any(lib in line for line in toc.contents),
                    f'{lib} in !!Libs, but not used in !!Libs.toc'
                )

        # Check every file in the toc exists
        for line in toc.contents:
            if line.startswith('#') or line == '\n':
                continue
            path = root / line.strip()
            self.assertTrue(
                os.path.exists(str(path).replace('\\', '/', -1)),
                f'{path} in !!Libs.toc, but not exists!'
            )

    def test_check_duplicate_libraries(self):
        libs = get_libraries_list()

        ignored = ['FrameXML', 'textures']
        libs = set(libs) - set(ignored)
        duplicates = {}
        for root, dirs, _ in os.walk('AddOns'):
            if '!!Libs' in root:
                continue

            dup = set(dirs).intersection(libs)
            if dup:
                duplicates[root] = dup

        if duplicates:
            print('Found below duplicate libraries:')
            pprint(duplicates)

            # Ignore these embedded liraries, as they have customized versions
            whitelist = ['Questie', 'RareScanner']

            for k in duplicates:
                paths = []
                head = k
                tail = ''
                while head:
                    head, tail = os.path.split(head)
                    paths.append(tail)

                addon = paths[-2]
                if addon not in whitelist:
                    self.fail(f'Found duplicated libraries in {addon}')
