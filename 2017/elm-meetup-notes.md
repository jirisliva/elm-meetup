# Elm MeetUp

- organizace kodu
- problemy a reseni (js api)
- vyhody
- nedostatky
- nastroje
- Jak se rychle zapojí noví lidé do vývoje v Elmu? 

- ukazka: debuggery


## Přínosy vs omezení z pohledu praktického použití

### Cons
#### VDOM
 - Stejne jako Rect.js (dalsi technologie pouzivajici VDOM)
 - dusledky
   - Neni mozne primo menit DOM (vcetne operaci jako je pridani event listeneru. 
#####  Omezeni dane Elmem
- JS DOM API (getBoundingClientRect())
	- port - priklad se ziskanim hlastnosti webview 
	- native module - priklad (pro animace, getBoundingClientRect)
    
### Co Elmu jako platforme stale chybi
    - Privatni package (dnes jsou pouze verejne baliky pres github), Elm 0.19
    - Debugger je cool, ale stale je to jen zacatek
	    - priklad a porovnani elm vs. komunitni
	    
### Pros
  - Rychly vyvoj. Je snadne zacit prototypem a pak refaktorovat a pridavat dalsi veci.
  - Bezproblemovy refactoring
  - No runtime errors - je to pravda :)
  - Radost! Je snadne se pro Elm nadchnout. ciste funkcionalni jazyk ve spojeni s "Elm Architecture" (Event -Update-View pusobi naprosto prirozene. Elm muze byt idealni vstupnim jazykem do funcionániho sveta. (dnes uz bych se neobaval pouzit ciste funkcionalni jazyk pro backend, Elixir?)
  - Hodne casti ktere jsem planovali nechat v JS jsme zacali prepisovat do Elmu
  - HTML to Elm - neco vypada jako hricka dokaze setrit hodne casu. 

### Priklady / ukazky

 - Debuging 
    - Debugger Elm 0.18 (nahrat stav ze souboru)
    - Community Debugger - Ukazka v electronu


##  Úskalí vývoje většího produktu, atd.
(What challenges we have faced and what stages of dev we have passed)

### Organizace kodu 
    - Co jsme zkusili
    - Co jsme se rozhodli zmenit (a proc)
    - Jak vypada nase dnesni struktura kodu
      - Co bychom na ni chteli zmenit
    - Jak vypada Model
 
 dve cesty
 1 maximalne oddelit casti "komponenty" od sebe
 2 mit vsechno v jednom "scope"
 
 "instinktivne" jsme zacali s prvni cestou (navyk delit kod do "kompoment").
 pozdeji jsme se prikkonili k druhe ceste. kod je jednodussi (bez mapovni zprav) a nenasli jsme mnoho objektivnich argumentu proc kod prisne delit - efekt cistych funkci?
 
 misto znovu pouzitelmych komponent mame znovu pouzitelne view funkce. 

 zamerit se asi pouze na porovnani zvyklosti z jinych jazyku a predstaveni myslenky, 
 ze ne vzdy je jsou tyhle zvyklosti nejlepsi

 Priklady cleneni
 1. "komponenty" - mapovani Msg
 2. flat - vsechno v jednom (Model.elm, Msg.elm, Update.elm, View.elm)
 3. flat - clenit podle potreb 
            Model                     -> Address.elm
              address: Address              - type Address
            Msg                             - helper funkce
              AddressMsg                    - updateAddress
            Update                          - AddressMsg
                updateAddress

 
### Nastroje
    - Editory / IDE
    - Testy

## Jak se rychle zapojí noví lidé do vývoje v Elmu? 
(Learning curve - how long it takes to Elm newcomers become productive)

  - vyvojář bez predchozi zkusenosti s funkcionalnimi jazyky byl schopen paar produkcni kod po 3 týdnech
  - Elm komunita (napr. na Slacku) je _velmi_ vstricna k zacatecnikum



https://www.facebook.com/events/338267139940639/

# Elm Europe - Napady na zmeny ve strukture Elm kodu v Editoru a Portalu

## Modules (evancz) 
https://www.youtube.com/watch?v=2ihTgEYiKpI

Vice organizovat helper funkce (utils) okolo typu se kterymi pracuji.
(konec koncu, podobne jsou organizovany i baliky/knihovny)

Napr.
Guides.elm
 - typy: Guide, GuideStep (GuideModel, GuideStepModel
 - vsechny funkce slouzici pro zmeny, hledani, trideni Guides a Steps

GuidesMsg a update funkce zustava stale v Msg.elm resp. UpdateGuides.elm
Nebo jit jeste dal a presunout do Guides.elm i GuidesMsg a updateGuides


Pak by melo smysl presnout definice typu mimo modul Model.elm
Omezi se znalost detailu v typech na jeden modul.
Hranice unit testu by byly taky jasnejsi.

## Extensible records (feldman)
https://www.youtube.com/watch?v=DoA4Txr4GUs

