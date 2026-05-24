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

- Klienti: `sf_clients_search`, `sf_clients_list`, `sf_clients_get`, `sf_clients_create_preview`, `sf_clients_create`, `sf_clients_update_preview`, `sf_clients_update`, `sf_clients_delete_preview`, `sf_clients_delete`.
- Klientske doklady: `sf_documents_list`, `sf_documents_get`, `sf_documents_create_preview`, `sf_documents_create`, `sf_documents_update_preview`, `sf_documents_update`, `sf_documents_delete_preview`, `sf_documents_delete`.
- Odoslanie dokladu: `sf_documents_send_email_preview`, potom `sf_documents_send_email`.
- Uhrada dokladu: `sf_documents_add_payment_preview`, potom `sf_documents_add_payment`.
- Kontaktne osoby klienta: `sf_contact_persons_*`, iba ak su potrebne pre klientsky doklad.
- Ciselniky: `sf_value_lists_*`, iba ak su potrebne pre klientsky doklad.
- Priame API: `sf_api_get`, `sf_api_write_preview`, `sf_api_write`, iba ked klientsku operaciu nepokryva strukturovany `sf_*` nastroj.

## Bezpecny Zapis

Kazdy zapis, zmazanie, odoslanie a uhrada ma tri kroky:

1. Najdi presny ciel a over ID, typ dokladu, klienta a sumy.
2. Zavolaj preview tool, napriklad `sf_documents_create_preview`.
3. Pouzivatelovi ukaz zhrnutie, riziko a `confirmation_id`.
4. Execute tool volaj az po explicitnom potvrdeni v aktualnej konverzacii.
5. Execute toolu posli iba `confirmation_id`.

Ak chyba klient, suma, DPH, mena, datum, splatnost alebo polozky, najprv sa opytaj. Nevymyslaj ceny, polozky ani obchodne podmienky.

## Quick Reads

- Posledna ostra faktura: `sf_documents_list` s `type=regular`, `per_page=1`, `page=1`, `sort=created`, `direction=DESC`.
- Poslednych N ostrych faktur: rovnake volanie s `per_page=N`.
- Posledna cenova ponuka: `sf_documents_list` s `type=estimate`, `per_page=1`, `page=1`, `sort=created`, `direction=DESC`.
- Detail dokladu: `sf_documents_get`, az ked treba polozky, PDF alebo uplny detail.
- Vystavil/autor ponuky: najdi doklad cez `sf_documents_list`, potom pouzi `sf_api_get` s `path="/invoices/view/{id}.json"` a citaj `Invoice.issued_by`.
