package edu.escola.sistemaedu.registroaula.dadoacademico;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DadoAcademicoForm {

    private String serieEscolar;
    private String escolaridadeAtual;
    private String orgaoInstituicaoEmpresa;

}