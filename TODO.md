# TODO

1. ~~Substituir o termo 'Analises' por 'Relatórios'.~~

2. Mover o relatório 'Rebanho' para a página inicial.

3. ~~Substituir o nome da aba 'Matrizes' por 'Desempenho das Matrizes'.~~

4. ~~Substituir o termo 'entrada' por 'aquisição'.~~

5. ~~Substituir o termo 'reprodutor' por 'matriz' caso o animal seja fêmea.~~

6. ~~Substituir o termo 'descarte' por 'finalização'.~~

7. ~~Substituir o termo 'Diagnosticar Reprodução' por 'Registrar Diagnóstico Reprodução'.~~

8. Checar erros de ortografia. Reportados:
    - Tirar acento de gravidez.
    - Registro de prenhe Z.
    - Tirar o acento do gravidez.

9. ~~Apresentar as funcionalidades na seguinte ordem:~~
    - ~~Relatórios~~
    - ~~Rebanho~~
    - ~~Reprodutores~~
    - ~~Reprodução~~
    - ~~Desmame~~
    - ~~Tratamento~~
    - ~~Finalização~~

10. ~~Adicionar novos tipos de Finalização:~~
    ~~"Alterar banco e formulários."~~
    - ~~Descarte:~~
        - ~~Exemplo: Animal geneticamente ruim. Animal improdutivo.~~
        - ~~Pesos registrados: Nenhum.~~
    - ~~Venda:~~
        - ~~Exemplo: Animal vendido a outro produtor.~~
        - ~~Pesos registrados: Nenhum.~~
    - ~~Morte:~~
        - ~~Exemplo: Animal morre por uma doença.~~
        - ~~Pesos registrados: Nenhum.~~
    - ~~Abate:~~
        - ~~Exemplo: Animal vendido ao frigorífico.~~
        - ~~Pesos registrados: Peso ao abate e peso da carcaça quente.~~

11. ~~Criar 'Controller' e 'Persistence' separados para a finalização.~~

12. ~~Implementar 'Visualizar Desmames'.~~

13. Implementar 'Visualizar Tratamentos'.

14. Adicionar elemento que lista tratamentos nos detalhes do animal.

15. Na página de detalhes do animal:
    - Caso ela esteja reproduzindo, ou prenha, mostrar as informações e possibilidar editar / deletar.

16. ~~Na página que lista os animais em tratamento, em reprodução e fêmeas prenhas:~~
    - ~~Fazer com que cada painel seja paginável para carregar mais objetos.~~
    - ~~Cada painel em uma *tab* diferente.~~

17. Estilizar o seletor de animais e reprodutores.

18. ~Mover todas as estilização pro argumento 'theme' no arquivo 'main.dart'.~

19. Implementar SQL que recupera as mesmas informações do relatório de matrizes para as crias de uma determinada vaca:
    - Nome, Peso ao Nascimento, Peso a Desmama, Pesoa ao Sobreano, Idade ao Primeiro Parto.
    - static Future<List<(String, double?, double?, double?, int?)>> getOffspringStatistics(int brinco);

20. Implementar SQL que recupera quantas vezes em sequência a tentativa de reprodução vem falhando para uma vaca:
    - Exemplos:
        - Sequência de diagnósticos: () / Retorno: 0
        - Sequência de diagnósticos: (+ - - -) / Retorno: 3
        - Sequência de diagnósticos: (+) / Retorno: 0
        - Sequência de diagnósticos: (+ - -) / Retorno: 2
        - Sequência de diagnósticos: (+ - - + -) / Retorno: 1

21. Adicionar a informação do item 19 e 20 na tabela de desempenho das matrizes: Ao clicar na linha da matriz mostrar o desempenho das crias.
