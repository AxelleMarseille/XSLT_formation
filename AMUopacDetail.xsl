<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:items="http://www.koha-community.org/items" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="marc items">

<xsl:import href="AMUopacTemplates.xsl"/>
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="marc:record">

  <xsl:variable name="biblionumber" select="marc:controlfield[@tag=001]"/>
  <xsl:variable name="PPN" select="marc:controlfield[@tag=009]"/>
  <xsl:variable name="CoAR" select="marc:datafield[@tag=325]/marc:subfield[@code='j']"/>
  <xsl:variable name="CoARp0" select="substring($CoAR,1,1)"/>
  <xsl:variable name="CoARp1" select="substring($CoAR,2,1)"/>
  <xsl:variable name="CoARp2" select="substring($CoAR,3,1)"/>
  <xsl:variable name="CoARp34" select="substring($CoAR,4,2)"/>

<div id="opacxslt">

<xsl:if test="marc:datafield[@tag=099] or marc:datafield[@tag=200]">
      <h2>
        <xsl:if test="marc:datafield[@tag=200]">
          <xsl:call-template name="tag_200" />
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']">
          <xsl:call-template name="support_img">
            <xsl:with-param name="support" select="marc:datafield[@tag=099]/marc:subfield[@code='t']" />
          </xsl:call-template>
        </xsl:if>
      </h2>
</xsl:if>

<dl>

<xsl:if test="marc:datafield[@tag=530 and @ind1=1] or marc:datafield[@tag=510]">
  <dt class="labelxslt">Autre(s) titre(s) : </dt>
      <xsl:call-template name="tag_5xx" />
</xsl:if>

<xsl:if test="marc:datafield[@tag &gt;= 700 and @tag &lt; 800]">
    <dt class="labelxslt">Auteur(s)</dt>
      <xsl:call-template name="tag_7xx" />
</xsl:if>

<xsl:if test="marc:datafield[@tag=010] or marc:datafield[@tag=011]">
  <xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='a']">
    <dt class="labelxslt">ISBN</dt>
    <dd>
    <xsl:for-each select="marc:datafield[@tag=010]/marc:subfield[@code='a']">
      <xsl:value-of select="."/>
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text> </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
    </dd>
  </xsl:if>
  <xsl:if test="marc:datafield[@tag=011]/marc:subfield[@code='a']">
    <dt class="labelxslt">ISSN</dt>
    <dd>
      <xsl:for-each select="marc:datafield[@tag=011]/marc:subfield[@code='a']">
        <xsl:value-of select="."/>
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text> </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </dd>
  </xsl:if>
</xsl:if>

<xsl:if test="marc:datafield[@tag=101]">
  <dt class="labelxslt">Langue(s)</dt>
    <dd>
    <xsl:for-each select="marc:datafield[@tag=101]">
      <xsl:for-each select="marc:subfield[@code='a']">
        <xsl:value-of select="."/>
        <xsl:choose>
          <xsl:when test="position()=last()">
            <xsl:text></xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:for-each>
  </dd>
</xsl:if>

<xsl:if test="marc:datafield[@tag=205]">
  <dt class="labelxslt">Edition</dt>
  <dd>
    <xsl:for-each select="marc:datafield[@tag=205]/marc:subfield[@code='a']">
      <xsl:value-of select="."/>
    </xsl:for-each>
  </dd>
</xsl:if>

<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']!='Thèses et mémoires' and marc:datafield[@tag=099]/marc:subfield[@code='t']!='Thèses électroniques'">
  <xsl:if test="marc:datafield[@tag=210]">
    <dt class="labelxslt">Publication</dt>
      <xsl:for-each select="marc:datafield[@tag=210]">
        <dd>
          <xsl:call-template name="addClassRtl" />
          <xsl:value-of select="marc:subfield[@code='a']"/>
          <xsl:if test="marc:subfield[@code='b']">
            <xsl:if test="marc:subfield[@code='a']">, </xsl:if>
            <xsl:value-of select="marc:subfield[@code='b']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='a' or @code='b']">
            <xsl:if test="marc:subfield[@code='c']"> : </xsl:if>
            <xsl:value-of select="marc:subfield[@code='c']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='d']">
            <xsl:if test="marc:subfield[@code='a' or @code='c']">, </xsl:if>
            <xsl:value-of select="marc:subfield[@code='d']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='e'or @code='f'or @code='g'or @code='h']">
          <xsl:text> (</xsl:text>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='e']">
            <xsl:if test="marc:subfield[@code='a' or @code='c' or @code='d']"> — </xsl:if>
            <xsl:value-of select="marc:subfield[@code='e']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='f']">
            <xsl:if test="marc:subfield[@code='e']"> </xsl:if>
            <xsl:value-of select="marc:subfield[@code='f']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='g']">
            <xsl:if test="marc:subfield[@code='f']"> : </xsl:if>
            <xsl:value-of select="marc:subfield[@code='g']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='h']">
            <xsl:if test="marc:subfield[@code='e' or @code='g']">, </xsl:if>
            <xsl:value-of select="marc:subfield[@code='h']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='e'or @code='f'or @code='g'or @code='h']">
          <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:value-of select="marc:subfield[@code='r']"/>
          <xsl:if test="marc:subfield[@code='s']">
            <xsl:if test="marc:subfield[@code='r']"> (</xsl:if>
            <xsl:value-of select="marc:subfield[@code='s']"/>)
          </xsl:if>
        </dd>
        </xsl:for-each>
  </xsl:if>
  <xsl:if test="marc:datafield[@tag=214]">
    <dt class="labelxslt">Publication</dt>
      <xsl:for-each select="marc:datafield[@tag=214]">
        <dd>
          <xsl:call-template name="addClassRtl" />
          <xsl:value-of select="marc:subfield[@code='a']"/>
          <xsl:if test="marc:subfield[@code='b']">
            <xsl:if test="marc:subfield[@code='a']">, </xsl:if>
            <xsl:value-of select="marc:subfield[@code='b']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='a' or @code='b']">
            <xsl:if test="marc:subfield[@code='c']"> : </xsl:if>
            <xsl:value-of select="marc:subfield[@code='c']"/>
          </xsl:if>
          <xsl:if test="marc:subfield[@code='d']">
            <xsl:if test="marc:subfield[@code='a' or @code='c']">, </xsl:if>
            <xsl:value-of select="marc:subfield[@code='d']"/>
          </xsl:if>
          <xsl:value-of select="marc:subfield[@code='r']"/>
          <xsl:if test="marc:subfield[@code='s']">
            <xsl:if test="marc:subfield[@code='r']"> (</xsl:if>
            <xsl:value-of select="marc:subfield[@code='s']"/>)
          </xsl:if>
        </dd>
        </xsl:for-each>
  </xsl:if>
</xsl:if>

<xsl:if test="marc:datafield[@tag=215]">
  <dt class="labelxslt">Description</dt>
  <dd>
    <xsl:for-each select="marc:datafield[@tag=215]">
        <xsl:if test="marc:subfield[@code='a']">
          <xsl:value-of select="marc:subfield[@code='a']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='c']">
          <xsl:if test="marc:subfield[@code='a']"> : </xsl:if>
          <xsl:value-of select="marc:subfield[@code='c']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='d']">
          <xsl:if test="marc:subfield[@code='a' or @code='c']"> ; </xsl:if>
          <xsl:value-of select="marc:subfield[@code='d']"/>
        </xsl:if>
        <xsl:if test="marc:subfield[@code='e']">
          <xsl:if test="marc:subfield[@code='a' or @code='c' or @code='d']"> + </xsl:if>
          <xsl:value-of select="marc:subfield[@code='e']"/>
        </xsl:if>
        <xsl:text>. </xsl:text>
    </xsl:for-each>
  </dd>
</xsl:if>

<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Thèses et mémoires' or marc:datafield[@tag=099]/marc:subfield[@code='t']='Thèses électroniques'">
  <xsl:if test="marc:datafield[@tag=328]">
  <dt class="labelxslt">Thèse</dt>
    <dd>
      <xsl:for-each select="marc:datafield[@tag=328]">
        <xsl:for-each select="marc:subfield">
          <xsl:value-of select="text()"/>
          <xsl:choose>
            <xsl:when test="position()=last()">
              <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> : </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:for-each>
    </dd>
  </xsl:if>
</xsl:if>

<xsl:if test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Livres électroniques'">
	<xsl:if test="marc:datafield[@tag=324]">
	<dt class="labelxslt">Document original</dt>
		<xsl:for-each select="marc:datafield[@tag=324]">
        <dd>
			<xsl:for-each select="marc:subfield">
				<xsl:value-of select="text()"/>
			</xsl:for-each>
		</dd>
		</xsl:for-each>
	</xsl:if>
</xsl:if>

<xsl:if test="marc:datafield[@tag &gt;= 300 and @tag &lt; 400]">
  <dt class="labelxslt">Note(s) et résumé(s)</dt>
 <dd>
    <a class="amunotes" href="#descriptions">
     <xsl:text>Plus d'infos</xsl:text>
    </a>
 </dd>
</xsl:if>

<xsl:if test="marc:datafield[@tag &gt;= 600 and @tag &lt; 620]">
  <dt class="labelxslt">Sujet(s)</dt>
    <xsl:call-template name="tag_6xx"/>
</xsl:if>

<xsl:if test="marc:datafield[@tag &gt;= 400 and @tag &lt; 500]">
	<dt class="labelxslt">Autres titres en lien</dt>
	<xsl:call-template name="tag_4xx"/>
</xsl:if>


<xsl:if test="marc:datafield[@tag=923 or @tag=930] and marc:datafield[@tag=099]/marc:subfield[@code='t']='Périodiques'">
    <dt class="labelxslt">Collection</dt>
         <xsl:for-each select="marc:datafield[@tag=923]">
            <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d']">
              <dd>
              <xsl:if test="marc:subfield[@code='c']">
                	<xsl:call-template name="RCR">
        		      <xsl:with-param name="code" select="marc:subfield[@code='c']"/>
        	      	</xsl:call-template>
  	          </xsl:if>
        	      <xsl:if test="marc:subfield[@code='d']">
                  <xsl:text> : </xsl:text>
                  <span class="available">
        		        <xsl:value-of select="marc:subfield[@code='d']"/>
                  </span>
        	      </xsl:if>
              </dd>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='a']">
              <dd>
                <span class="fctxslt">
                  <xsl:text>Lacunes : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='a']"/>
                </span>
              </dd>
            </xsl:if>
			<xsl:if test="marc:subfield[@code='f']">
              <dd>
                <span class="fctxslt">
                  <xsl:text>Suppléments : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='f']"/>
                </span>
              </dd>
            </xsl:if>
            <xsl:if test="marc:subfield[@code='b'] or marc:subfield[@code='g'] or marc:subfield[@code='h']">
              <dd>
                <span class="fctxslt">
                <xsl:if test="marc:subfield[@code='b']">
                  <xsl:text>Cote : </xsl:text>
                  <xsl:value-of select="marc:subfield[@code='b']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='g']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='b']">
                        <xsl:text> ; Localisation : </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>Localisation : </xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='g']" />
                </xsl:if>
                <xsl:if test="marc:subfield[@code='h']">
                    <xsl:choose>
                      <xsl:when test="marc:subfield[@code='b'] or marc:subfield[@code='g']">
                        <xsl:text> ; </xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                      </xsl:otherwise>
                    </xsl:choose>
                  <xsl:value-of select="marc:subfield[@code='h']" />
                </xsl:if>
              </span>
              </dd>
            </xsl:if>
        </xsl:for-each>
		<xsl:for-each select="marc:datafield[@tag=930]">
			<xsl:if test="marc:subfield[@code='z'] or marc:subfield[@code='p']">
			<dd>
			<span class="fctxslt">
				<xsl:text>Conservation : </xsl:text>
					<xsl:value-of select="marc:subfield[@code='z']" />
					<xsl:text> (</xsl:text>
					<xsl:value-of select="marc:subfield[@code='p']" />
					<xsl:text>)</xsl:text>
			</span>
			</dd>
			</xsl:if>
		  </xsl:for-each>
</xsl:if>

</dl>

</div>

<div id="lienxslt">
	<xsl:choose>
		<xsl:when test="marc:datafield[@tag=099]/marc:subfield[@code='t']='Thèses électroniques'">
			<xsl:choose>
				<xsl:when test="marc:datafield[@tag=856]">
					<dt>
					<img src="/assets/koha_acceder.png" alt="Document en ligne" align="middle" title="Document en ligne" />
					<xsl:choose>
						<xsl:when test="count(marc:datafield[@tag=856]/marc:subfield[@code='u'])=1">
							<xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='u']">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
									<xsl:text>Accès en ligne</xsl:text>
								</a>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='u']">
							  <xsl:choose>
								<xsl:when test="not(position()=last())">
									  <a>
										<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
										<xsl:text>Accès en ligne</xsl:text>
									  </a>
									  <xsl:text> | </xsl:text>
								</xsl:when>
								<xsl:otherwise>
								  <a>
									<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
									<xsl:text>Autre accès</xsl:text>
								  </a>
								</xsl:otherwise>
							  </xsl:choose>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					</dt>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Aucune version de cette thèse n'est disponible en ligne.</xsl:text>
					<xsl:if test="marc:datafield[@tag=456]">
						<xsl:text> Une version imprimée de cette thèse est disponible </xsl:text>
							<xsl:if test="marc:datafield[@tag=456]/marc:subfield[@code='0']">
								<xsl:element name="a">
									<xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=kw:<xsl:value-of select="marc:datafield[@tag=456]/marc:subfield[@code='0']"/></xsl:attribute>
										<xsl:text>en bibliothèque</xsl:text>
								</xsl:element>
							</xsl:if>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="marc:datafield[@tag=856]/marc:subfield[@code='u']">
			  <dt>
			  <img src="/assets/koha_acceder.png" alt="Document en ligne" align="middle" title="Document en ligne" />
			  <xsl:choose>
				<xsl:when test="count(marc:datafield[@tag=856]/marc:subfield[@code='u'])>1">
				  <xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='u']">
					<xsl:choose>
					  <xsl:when test="not(position()=last())">
							  <a>
								<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
								<xsl:text>Accès en ligne</xsl:text>
							  </a>
							  <xsl:text> | </xsl:text>
						</xsl:when>
						<xsl:otherwise>
						  <a>
							<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
							<xsl:text>Autre accès</xsl:text>
						  </a>
						</xsl:otherwise>
					  </xsl:choose>
					  </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='u']">
				  <a>
					<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
					<xsl:text>Accès en ligne</xsl:text>
				  </a>
				  </xsl:for-each>
				</xsl:otherwise>
			  </xsl:choose>
			  </dt>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:if test="marc:controlfield[@tag=009]">
        <dt style="font-weight: normal">
          <img src="/assets/ABES_sudoc_logo.gif" alt="Icone SUDOC" width="25" height="25" title="Chercher dans le SUDOC" />
            <a>
              <xsl:attribute name="href">//www.sudoc.fr/<xsl:value-of select="$PPN"/></xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:text> Chercher dans le SUDOC</xsl:text>
            </a>
        </dt>
    </xsl:if>
</div>

</xsl:template>

<xsl:template name="RCR">
  <xsl:param name="code"/>
  <xsl:choose>
    <xsl:when test="$code='130015206'">Aix - Saporta - AGCCPF-PACA</xsl:when>
    <xsl:when test="$code='130052201'">Aubagne - SATIS image et son</xsl:when>
    <xsl:when test="$code='130012213'">Aix - Schuman - UFR civilisations et humanités</xsl:when>
    <xsl:when test="$code='130012215'">Aix - Schuman - UFR géographie</xsl:when>
    <xsl:when test="$code='130012214'">Aix - Schuman - UFR LAG-LEA</xsl:when>
    <xsl:when test="$code='130012221'">Aix - Schuman - UFR LACS patio nord</xsl:when>
    <xsl:when test="$code='130552107'">Marseille - Château Gombert - Sciences et technologie</xsl:when>
    <xsl:when test="$code='130012101'">Aix - Fenouillères - Lettres et sciences humaines</xsl:when>
  	<xsl:when test="$code='130552104'">Marseille - St-Charles - Sciences, lettres et sciences humaines</xsl:when>
    <xsl:when test="$code='130552316'">Marseille - St-Charles - CRFCB</xsl:when>
    <xsl:when test="$code='041922301'">St Michel l'Observatoire - Observatoire de Haute Provence</xsl:when>
    <xsl:when test="$code='130552304'">Bibliothèque Observatoire Château-Gombert</xsl:when>
    <xsl:when test="$code='130552205'">Marseille - Château-Gombert - Observatoire</xsl:when>
    <xsl:when test="$code='130559902'">Aix-Marseille 1 - Bibliothèque électronique</xsl:when>
    <xsl:when test="$code='130559903'">Aix-Marseille 3 - Bibliothèque électronique</xsl:when>
    <xsl:when test="$code='130552207'">Marseille - Canebière - ESPE</xsl:when>
    <xsl:when test="$code='040702202'">Digne - Inspé</xsl:when>
    <xsl:when test="$code='840072203'">Avignon - Inspé</xsl:when>
    <xsl:when test="$code='130012224'">Aix - Isaac - Inspé</xsl:when>
    <xsl:when test="$code='130559901'">Aix-Marseille 2 - Bibliothèque électronique</xsl:when>
    <xsl:when test="$code='050612101'">Gap - Pôle universitaire</xsl:when>
    <xsl:when test="$code='130552206'">Marseille - Endoume - Centre d'océanologie</xsl:when>
    <xsl:when test="$code='130552106'">Marseille - Luminy - Sciences</xsl:when>
    <xsl:when test="$code='130552105'">Marseille - Timone - Pharmacie</xsl:when>
    <xsl:when test="$code='130559904'">Aix-Marseille - Bibliothèque électronique</xsl:when>
    <xsl:when test="$code='130552103'">Marseille - Timone - Médecine et odontologie</xsl:when>
    <xsl:when test="$code='130552101'">Marseille - Nord - Médecine</xsl:when>
    <xsl:when test="$code='130012104'">Aix - Ferry - Economie et gestion</xsl:when>
    <xsl:when test="$code='130552109'">Marseille - Bernard du Bois - Economie et gestion</xsl:when>
    <xsl:when test="$code='130012229'">Aix - Schweitzer - IUT - CS-GU-SAP</xsl:when>
    <xsl:when test="$code='130012232'">Aix - Gaston Berger - IUT</xsl:when>
    <xsl:when test="$code='130012222'">Aix - Gambetta - IRT</xsl:when>
    <xsl:when test="$code='130012223'">Aix - Cité du livre - IUT - IC-ML</xsl:when>
    <xsl:when test="$code='130282201'">La Ciotat - IUT - HSE</xsl:when>
    <xsl:when test="$code='130012102'">Aix - Schuman - Droit et économie</xsl:when>
    <xsl:when test="$code='130012103'">Aix - Montperrin - Sciences et droit</xsl:when>
    <xsl:when test="$code='130012202'">Aix - Schuman - Salle de droit privé</xsl:when>
    <xsl:when test="$code='130012203'">Aix - Schuman - CRA</xsl:when>
    <xsl:when test="$code='130012204'">Puyricard - IAE</xsl:when>
    <xsl:when test="$code='130012205'">Aix - Poncet - ISPEC</xsl:when>
    <xsl:when test="$code='130012206'">Aix - Saporta - IEP</xsl:when>
    <xsl:when test="$code='130012210'">Aix - Schuman - Cassin - CERIC</xsl:when>
    <xsl:when test="$code='130012211'">Aix - Schuman - UFR FEA</xsl:when>
    <xsl:when test="$code='130012212'">Aix - Gambetta - IEFEE</xsl:when>
    <xsl:when test="$code='130012216'">Aix - Schuman - CREEADP</xsl:when>
    <xsl:when test="$code='130012218'">Aix - Schuman - Théorie du droit</xsl:when>
    <xsl:when test="$code='130012219'">Aix - Schuman - Salle d'histoire des institutions</xsl:when>
    <xsl:when test="$code='130012220'">Aix - Schuman - Cassin - Droit public</xsl:when>
  	<xsl:when test="$code='130042202'">Arles - Antenne universitaire</xsl:when>
    <xsl:when test="$code='130552102'">Marseille - St-Jérôme - Sciences - Inspé</xsl:when>
  	<xsl:when test="$code='130552108'">Marseille - Canebière - Droit et économie</xsl:when>
    <xsl:when test="$code='130012233'">Aix - Schuman - Cassin - GERJC</xsl:when>
    <xsl:when test="$code='130012201'">Aix - Schuman - Cassin - Droit des affaires</xsl:when>
    <xsl:when test="$code='130012225'">Aix - Schuman - Cassin - IREDIC</xsl:when>
    <xsl:when test="$code='130012226'">Aix - Schuman - Cassin - Droit social</xsl:when>
    <xsl:when test="$code='130012228'">Aix - Schuman - Cassin - CEFF</xsl:when>
    <xsl:when test="$code='130012227'">Aix - Schuman - Cassin - Périodiques</xsl:when>
    <xsl:when test="$code='130012234'">Aix - Poncet – Urbanisme</xsl:when>
    <xsl:when test="$code='130012303'">Aix - Arbois - CEREGE</xsl:when>
    <xsl:when test="$code='130012235'">Aix - Saporta - IMPGT</xsl:when>
    <xsl:when test="$code='130552209'">Aix - CEFEDEM-SUD</xsl:when>
    <xsl:when test="$code='130555208'">Marseille - Nord - UMR 7268 - Anthropologie bioculturelle</xsl:when>
    <xsl:when test="$code='130555104'">Marseille - Timone - UMR 7268 - EEM</xsl:when>
    <xsl:when test="$code='130555403'">Marseille - Timone - UMR 7268 - EFS</xsl:when>
    <xsl:when test="$code='130552208'">Marseille - Timone - Médecine légale</xsl:when>
    <xsl:when test="$code='à venir'">Bibliothèque de l'IEP – Espace Philippe Seguin</xsl:when>
    <xsl:when test="$code='130012236'">Aix - Pasteur - Laboratoire Parole et Langage (LPL)</xsl:when>
	<xsl:when test="$code='130012305'">Aix - Jas de Bouffan - MMSH</xsl:when>
	<xsl:when test="$code='132132301'">Marseille - Château-Gombert - Centrale Marseille</xsl:when>
	<xsl:when test="$code='130552210'">Marseille - Blanqui - IFMK</xsl:when>
	<xsl:when test="$code='132032201'">Marseille - Canebière - MIRREL</xsl:when>
    <xsl:otherwise><xsl:value-of select="$code"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
