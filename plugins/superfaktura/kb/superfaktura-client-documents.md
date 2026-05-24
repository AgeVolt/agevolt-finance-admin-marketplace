# SuperFaktura Client Documents KB

Tato KB je iba pre klientsku stranu SuperFaktury: klienti, cenove ponuky, predajne objednavky, zalohove faktury, ostre faktury, dodacie listy, odoslanie dokladu a uhrady.

Mimo scope: nakupne alebo dodavatelske objednavky, dodavatelske faktury, naklady, sklad, pokladna, tagy a vseobecna administracia SuperFaktury.

## Typy Klientskych Dokladov

| Typ | Pouzitie |
| --- | --- |
| `estimate` | Cenova ponuka pre klienta. |
| `order` | Predajna objednavka od klienta. |
| `proforma` | Zalohova faktura pre klienta. |
| `regular` | Ostra faktura pre klienta. |
| `delivery` | Dodaci list pre klienta. |
| `cancel` | Dobropis alebo storno, iba ked pouzivatel explicitne zada SuperFaktura payload alebo presny ciel. |

Nepouzivaj `reverse_order`; je to dodavatelska/nakupna objednavka a nepatri do tohto skillu.

## Povolene Nastroje

- Klienti: `sf.clients.search`, `sf.clients.list`, `sf.clients.get`, `sf.clients.create_preview`, `sf.clients.create`, `sf.clients.update_preview`, `sf.clients.update`, `sf.clients.delete_preview`, `sf.clients.delete`.
- Klientske doklady: `sf.documents.list`, `sf.documents.get`, `sf.documents.create_preview`, `sf.documents.create`, `sf.documents.update_preview`, `sf.documents.update`, `sf.documents.delete_preview`, `sf.documents.delete`.
- Odoslanie dokladu: `sf.documents.send_email_preview`, potom `sf.documents.send_email`.
- Uhrada dokladu: `sf.documents.add_payment_preview`, potom `sf.documents.add_payment`.
- Kontaktne osoby klienta: `sf.contact_persons.*`, iba ak su potrebne pre klientsky doklad.
- Ciselniky: `sf.value_lists.*`, iba ak su potrebne pre klientsky doklad.
- Priame API: `sf.api.get`, `sf.api.write_preview`, `sf.api.write`, iba ked klientsku operaciu nepokryva strukturovany `sf.*` nastroj.

## Bezpecny Zapis

Kazdy zapis, zmazanie, odoslanie a uhrada ma tri kroky:

1. Najdi presny ciel a over ID, typ dokladu, klienta a sumy.
2. Zavolaj preview tool, napriklad `sf.documents.create_preview`.
3. Pouzivatelovi ukaz zhrnutie, riziko a `confirmation_id`.
4. Execute tool volaj az po explicitnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak chyba klient, suma, DPH, mena, datum, splatnost alebo polozky, najprv sa opytaj. Nevymyslaj ceny, polozky ani obchodne podmienky.

## Quick Reads

- Posledna ostra faktura: `sf.documents.list` s `type=regular`, `per_page=1`, `page=1`, `sort=created`, `direction=DESC`.
- Poslednych N ostrych faktur: rovnake volanie s `per_page=N`.
- Posledna cenova ponuka: `sf.documents.list` s `type=estimate`, `per_page=1`, `page=1`, `sort=created`, `direction=DESC`.
- Detail dokladu: `sf.documents.get`, az ked treba polozky, PDF alebo uplny detail.
- Vystavil/autor ponuky: najdi doklad cez `sf.documents.list`, potom pouzi `sf.api.get` s `path="/invoices/view/{id}.json"` a citaj `Invoice.issued_by`.
