# Analisador Léxico - CET058

## [Wiki do projeto da matéria](https://github.com/cet058/2019.1/wiki#detalhes-do-projeto)

# Definições da Linguagem

## Hello World

```py
print("Hello World!");
```

## Tipos

Os tipos de dados que você pode utilizar são `int`, `double`, `string` e `bool`

## Comentários

```js
// You can comment like that
```

## Declarando Variáveis

```js
// Homitindo o tipo da variável

let x = 9; // Int
let y = 9.0; // Float
let z = true; // Bool
let c = "hello"; // String

// ou Deixando o tipo Explicito

let x: int = 9;
let y: float = 9.0;
let z: boolean = true;
let c: string = "hello";
```

`É importante notar que em qualquer uma das declarações a variavél mantém o tipo de sua primeira atribuição`

## Declarando Função

```go
func test(a: int, b: int) (bool) {

  ret (a + b) >= 10;
}
```

Os paramêtros da função dever ter os seus tipos declarados e em seguida o tipo de seu retorno, ambos entre parentêses.

O retorno da função deve vim logo após a palavra reservada `ret`

## Condições

```js
if (condicao) {
  // Faça
} else {
  // Faça
}
```

## Repetição

```js
while (condicao) {
  // Faca
}
```

Ou com o `For`

```js
for x in 9 do x++ {
  // Faça
}
```

## Operadores Aritméticos

Você pode utilizar os seguintes operadores:

| Operador | Explicação    |
| -------- | ------------- |
| `+`      | Soma          |
| `-`      | Subtração     |
| `*`      | Multiplicação |
| `**`     | Potenciação   |
| `/`      | Divisão       |
| `%`      | Módulo        |

## Operadores Lógicos

Você pode utilizar os seguintes operadores:

| Operador                  | Explicação     |
| ------------------------- | -------------- |
| `!`                       | Negação        |
| `&&`                      | E              |
| <code>&#124;&#124;</code> | Ou             |
| `<`                       | Menor          |
| `<=`                      | Menor ou Igual |
| `>`                       | Maior          |
| `>=`                      | Maior ou Igual |
| `!=`                      | Diferente      |
| `==`                      | Igual          |

## Input / Output

```js
let x = input("Digite algo > ");

print(x);
```
