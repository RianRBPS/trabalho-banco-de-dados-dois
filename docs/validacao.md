# Validação em 14 de outubro de 2026

Schema, dados fictícios e consultas executados com sucesso no PGlite 0.5.10, que executa PostgreSQL em WebAssembly, em banco descartável.

Resultados: consulta 1 retornou duas mídias para continuar assistindo; consulta 2 retornou três favoritos com notas e gêneros; consulta 3 retornou Ciência em Casa com duas sessões e dois perfis e Viagem ao Horizonte com uma sessão e um perfil, ambos no plano Família.

Restrições verificadas: rejeição de nota 6, reprodução que aponta simultaneamente para filme e episódio, título sem subtipo e perfil com assinante inexistente.

Não houve execução do CREATE DATABASE em servidor PostgreSQL: psql não está disponível no PATH e o Docker está desligado. O passo 3 foi entregue como script executável; o banco persistente do grupo ainda precisa ser criado em seu ambiente. A validação embarcada não substitui essa execução final.
