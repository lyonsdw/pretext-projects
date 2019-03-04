<!--**********************************************************
Copyright 2019  All Rights Reserved
Robert A. Beezer, David W. Farmer, Alex Jordan

This file is used by the PreTeXt project to track projects
authored and distributed with PreTeXt.  By contributing edits,
or new project files, you agree to transfer your copyright
interest to the individuals named above.
***********************************************************-->
<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="register">
    <html>
        <head>
            <script src="https://pretextbook.org/js/lib/jquery.min.js"/>
            <script src="https://pretextbook.org/js/lib/knowl.js"/>
            <link rel="stylesheet" type="text/css" href="./pretext-projects.css"/>
        </head>
        <body>
            <table class="projects">
                <xsl:apply-templates select="project"/>
            </table>
            <xsl:apply-templates select="." mode="summary-stats"/>
        </body>
    </html>
</xsl:template>

<xsl:template match="project">
    <tr>
        <xsl:apply-templates select="." mode="author-cell"/>
        <xsl:apply-templates select="." mode="title-cell"/>
        <xsl:apply-templates select="." mode="character-cell"/>
        <xsl:apply-templates select="." mode="legal-cell"/>
    </tr>
</xsl:template>

<xsl:template match="project" mode="author-cell">
    <td class="authors">
        <xsl:apply-templates select="author"/>
        <!-- overall affiliation, presumes no individual affiliations -->
        <xsl:if test="affiliation">
            <xsl:apply-templates select="affiliation"/>
        </xsl:if>
    </td>
</xsl:template>

<xsl:template match="author">
    <!-- issue newline for multiple author case -->
    <xsl:if test="preceding-sibling::author">
        <br/>
    </xsl:if>
    <!-- single author, optionally linked to @url -->
    <xsl:choose>
        <xsl:when test="@url">
            <a href="{@url}">
                <xsl:apply-templates select="displayname"/>
            </a>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="displayname"/>
        </xsl:otherwise>
    </xsl:choose>
    <!-- affiliation is option, no-op is OK -->
    <xsl:apply-templates select="affiliation"/>
</xsl:template>

<!-- *always* onto a newline -->
<xsl:template match="affiliation">
    <br/>
    <xsl:text>(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="project" mode="title-cell">
    <td class="title">
        <!-- title of the project, optionally linked  -->
        <!-- to overall project landing page          -->
        <xsl:choose>
            <xsl:when test="sites/@landing">
                <a href="{sites/@landing}">
                    <i>
                        <xsl:apply-templates select="title"/>
                    </i>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <i>
                    <xsl:apply-templates select="title"/>
                </i>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="." mode="site-list"/>
        <xsl:if test="description">
            <br/>
            <xsl:apply-templates select="description"/>
        </xsl:if>
    </td>
</xsl:template>

<xsl:template match="description">
    <xsl:variable name="id">
        <xsl:value-of select="../@xml:id"/>
    </xsl:variable>
    <a data-knowl="" class="id-ref" data-refid="hk-{$id}">
        <xsl:text>Description</xsl:text>
    </a>
    <div class="description-knowl" id="hk-{$id}">
        <article class="description">
            <xsl:copy-of select="*"/>
        </article>
    </div>
</xsl:template>


    <!-- <div id="hk-Jkl" class="hidden-content tex2jax_ignore"><article class="hiddenproof"><p id="p-34">We simply take the indicated derivative, applying Theorem <a data-knowl="./knowl/theorem-FTC.html" title="Theorem 2.1: The Fundamental Theorem of Calculus">2.1</a> at <a data-knowl="./knowl/equation-use-FTC.html" title="Equation 4.2">(4.2)</a></p> -->

<xsl:template match="project" mode="site-list">
    <xsl:if test="sites/@source|sites/@html|sites/@pdf|sites/@print|sites/@ancillary1">
        <br/>
        <xsl:if test="sites/@html">
            <a href="{sites/@html}">
                <xsl:text>Online</xsl:text>
            </a>
            <xsl:text>&#xa0;</xsl:text>
        </xsl:if>
        <xsl:if test="sites/@pdf">
            <a href="{sites/@pdf}">
                <xsl:text>PDF</xsl:text>
            </a>
            <xsl:text>&#xa0;</xsl:text>
        </xsl:if>
        <xsl:if test="sites/@print">
            <a href="{sites/@print}">
                <xsl:text>Print</xsl:text>
            </a>
            <xsl:text>&#xa0;</xsl:text>
        </xsl:if>
        <xsl:if test="sites/@ancillary1">
            <a href="{sites/@ancillary1}">
                <xsl:text>Ancillary</xsl:text>
            </a>
            <xsl:text>&#xa0;</xsl:text>
        </xsl:if>
        <xsl:if test="sites/@source">
            <a href="{sites/@source}">
                <xsl:text>Source</xsl:text>
            </a>
            <xsl:text>&#xa0;</xsl:text>
        </xsl:if>
    </xsl:if>
</xsl:template>

<xsl:template match="project" mode="character-cell">
    <td class="character">
        <!-- Subject first -->
        <xsl:if test="character/@subject">
            <xsl:choose>
                <xsl:when test="character/@subject='math'">
                    <xsl:text>Mathematics</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='cs'">
                    <xsl:text>Computer Science</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='physics'">
                    <xsl:text>Physics</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='engr'">
                    <xsl:text>Engineering</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='writing'">
                    <xsl:text>Writing</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='music'">
                    <xsl:text>Music</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='doc'">
                    <xsl:text>Documentation</xsl:text>
                </xsl:when>
                <xsl:when test="character/@subject='misc'">
                    <xsl:text>Miscellaneous</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Subject code not recognized (<xsl:value-of select="character/@subject"/>)</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- Audience level next -->
        <xsl:if test="character/@level">
            <xsl:if test="character/@subject">
                <br/>
            </xsl:if>
            <!--   @level: secondary, ugld, ugud, grad, research -->
            <xsl:choose>
                <xsl:when test="character/@level='secondary'">
                    <xsl:text>Secondary</xsl:text>
                </xsl:when>
                <xsl:when test="character/@level='ugld'">
                    <xsl:text>Undergrad (Lower)</xsl:text>
                </xsl:when>
                <xsl:when test="character/@level='ugud'">
                    <xsl:text>Undergrad (Upper)</xsl:text>
                </xsl:when>
                <xsl:when test="character/@level='grad'">
                    <xsl:text>Graduate</xsl:text>
                </xsl:when>
                <xsl:when test="character/@level='research'">
                    <xsl:text>Research</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Level code not recognized (<xsl:value-of select="character/@level"/>)</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- Development phase -->
        <xsl:if test="character/@phase">
            <xsl:if test="character/@subject|character/@level">
                <br/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="character/@phase='develop'">
                    <xsl:text>Developing</xsl:text>
                </xsl:when>
                <xsl:when test="character/@phase='ready'">
                    <xsl:text>Complete, Evolving</xsl:text>
                </xsl:when>
                <xsl:when test="character/@phase='mature'">
                    <xsl:text>Mature</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Phase code not recognized (<xsl:value-of select="character/@phase"/>)</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </td>
</xsl:template>

<xsl:template match="project" mode="legal-cell">
    <td class="legal">
        <xsl:if test="license">
            <xsl:choose>
                <xsl:when test="license/@code='all-rights'">
                    <xsl:text>&#xa9; </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&#x1F12F; </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="license/@code='all-rights'">
                    <xsl:text>Rights Reserved</xsl:text>
                </xsl:when>
                <xsl:when test="(license/@code='CC') or (license/@code='GFDL')">
                    <xsl:value-of select="license/@code"/>
                    <xsl:if test="license/@variant">
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="license/@variant"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>License code not recognized (<xsl:value-of select="license/@code"/>)</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
            <!-- perhaps modified by a version -->
            <xsl:if test="license/@version">
                <xsl:text> v</xsl:text>
                <xsl:value-of select="license/@version"/>
            </xsl:if>
            <!-- Publication year -->
            <xsl:if test="license/@pub-year">
                <!-- presume a license line always -->
                <br/>
                <xsl:text>(</xsl:text>
                <xsl:value-of select="license/@pub-year"/>
                <xsl:text>)</xsl:text>
            </xsl:if>

            <xsl:if test="license/@price">
                <!-- presume a license line always -->
                <br/>
                <xsl:text>Print: </xsl:text>
                <xsl:value-of select="license/@price"/>
            </xsl:if>





        </xsl:if>
    </td>
</xsl:template>








    <!-- License/Terms of Distribution -->
    <!-- CC-BY-SA, "All Rights Reserved", content allowed -->
    <!-- multiple licenses possible -->
    <!-- <license code="GFDL" variant="" version="" price="$30.19"/> -->




<!-- Summary Statistics -->

<xsl:template match="register" mode="summary-stats">
    <xsl:variable name="total" select="count(project)"/>
    <!-- Total Projects -->
    <p>
        <xsl:value-of select="$total"/>
        <xsl:text> projects.</xsl:text>
    </p>
    <!-- Subjects -->
    <p>
        <xsl:text>Mathematics: </xsl:text>
        <xsl:value-of select="count(project/character[@subject='math'])"/>
        <br/>
        <xsl:text>Computer Science: </xsl:text>
        <xsl:value-of select="count(project/character[@subject='cs'])"/>
        <br/>
    </p>
    <!-- Licenses -->
    <p>
        <xsl:text>CC License: </xsl:text>
        <xsl:value-of select="count(project/license[@code='CC'])"/>
        <br/>
        <xsl:text>GFDL License: </xsl:text>
        <xsl:value-of select="count(project/license[@code='GFDL'])"/>
        <br/>
        <xsl:text>All Rights Reserved: </xsl:text>
        <xsl:value-of select="count(project/license[@code='all-rights'])"/>
        <br/>
        <xsl:text>Not stated: </xsl:text>
        <xsl:value-of select="$total - count(project/license/@code)"/>
        <br/>
    </p>

</xsl:template>



</xsl:stylesheet>
