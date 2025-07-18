//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

@testable import Coenttb_Blog
import Dependencies
import DependenciesTestSupport
import Foundation
import HTML
import PointFreeHtmlTestSupport
import Testing

@Suite(
    "Blog test suite",
    .dependency(
        \.filenameToResourceUrl,
         filenameToResourceUrl
    ),
    .snapshots(
        record: nil
    )
)
struct TestSuite {
    @Test func test() async throws {
        @Dependency(
            \.blog.getAll
        ) var getAll

        let x = getAll()

        #expect(
            x.count == 1
        )
    }

    @Test
    func testBlogView() {
        assertInlineSnapshot(
            of: HTMLDocument {
                Blog.Post.View(post: .preview)
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html lang="en">
              <head>
                <style>
            .align-items-CdPBO2{align-items:center}
            .justify-content-CdPBO2{justify-content:center}
            .display-BvS8W3{display:flex}
            .padding-top-1VZj64{padding-top:4rem}
            .size-svP6w3{size:10rem}
            .position-Pjz1G2{position:relative}
            .height-svP6w3{height:10rem}
            .width-svP6w3{width:10rem}
            .clip-path-hE4yG3{clip-path:circle(50% )}
            .display-ix08W2{display:block}
            .height-C8uWv{height:100%}
            .width-C8uWv{width:100%}
            .position-X8qzJ{position:absolute}
            .border-style-Wl0y44{border-style:none}
            .max-width-C8uWv{max-width:100%}
            .object-position-YDrNP2{object-position:50% 50%}
            .object-fit-d9Lti{object-fit:cover}
            .height-HH4a64{height:300px}
            .background-color-XRqQ6{background-color:#3399ff}
            .padding-f9z9N1{padding:4rem 3rem}
            .padding-pRWYM{padding:4rem 2rem}
            .max-width-P6HnV{max-width:1280px}
            .align-items-0Zubr3{align-items:baseline}
            .justify-content-n56cj2{justify-content:flex-start}
            .flex-wrap-6YEaQ3{flex-wrap:wrap}
            .flex-direction-7gclL{flex-direction:column}
            .color-VJeYA{color:#000000}
            .line-height-z5kUh3{line-height:1.35}
            .font-weight-evfWi1{font-weight:normal}
            .font-variant-evfWi1{font-variant:normal}
            .font-style-evfWi1{font-style:normal}
            .font-stretch-evfWi1{font-stretch:normal}
            .font-size-xlo1p4{font-size:0.75rem}
            .font-family-TCJhi4{font-family:system-ui}
            .color-wIX6m4{color:rgba(60, 60, 67, 0.3)}
            .row-gap-NKv2f3{row-gap:0.5rem}
            .align-items-msN8p3{align-items:stretch}
            .margin-QlFKs1{margin:0px}
            .padding-QlFKs1{padding:0px}
            .line-height-9Qkso4{line-height:1.5}
            .border-radius-xypJ01{border-radius:6px}
            .padding-wKavA3{padding:1rem 1.5rem}
            .overflow-x-u7yQf2{overflow-x:auto}
            .margin-bottom-NKv2f3{margin-bottom:0.5rem}
            .color-K2J0r1{color:#121212}
            .background-c5ixr2{background:#fafafa}
            @media only screen and (min-width: 832px){
              .margin-FIMYj2{margin:0px auto}
              .width-w8QPf2{width:60%}
            }
            @media (prefers-color-scheme: dark) and print{
              .color-42SG31{color:#FFFFFF}
              .color-jJwsY2{color:rgba(235, 235, 245, 0.3)}
              .color-0lN2z4{color:#f5f5f5}
            }
            @media (prefers-color-scheme: dark){
              .background-Iaxl84{background:#171717}
            }

                </style>
              </head>
              <body>
            <div class="align-items-CdPBO2 justify-content-CdPBO2 display-BvS8W3 padding-top-1VZj64 size-svP6w3 position-Pjz1G2">
              <div class="height-svP6w3 width-svP6w3 position-Pjz1G2 clip-path-hE4yG3">
                <div class="display-ix08W2 height-C8uWv width-C8uWv position-X8qzJ">
                  <div class="border-style-Wl0y44 max-width-C8uWv width-C8uWv height-C8uWv object-position-YDrNP2 object-fit-d9Lti display-ix08W2 max-width-C8uWv height-HH4a64 width-C8uWv background-color-XRqQ6">
                  </div>
                </div>
              </div>
            </div>
            <div class="padding-f9z9N1 padding-pRWYM margin-FIMYj2 max-width-P6HnV align-items-0Zubr3 justify-content-n56cj2 flex-wrap-6YEaQ3 flex-direction-7gclL display-BvS8W3">
              <article class="width-C8uWv width-w8QPf2 margin-FIMYj2 color-VJeYA color-42SG31">
                <div class="line-height-z5kUh3 font-weight-evfWi1 font-variant-evfWi1 font-style-evfWi1 font-stretch-evfWi1 font-size-xlo1p4 font-family-TCJhi4 color-wIX6m4 color-jJwsY2">Blog 1 - Monday, 16 April 2018
                </div>
                <swift-html-markdown class="display-ix08W2">
                  <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Navigating GDPR Compliance in AI Projects: A Case Study
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Artificial Intelligence (AI) has become a cornerstone of innovation, transforming industries and redefining the possibilities of data analysis. However, as organizations increasingly leverage AI technologies, they face the challenge of navigating complex legal landscapes, particularly under the General Data Protection Regulation (GDPR). This blog post explores a case study that highlights the interplay between AI and GDPR, offering practical insights into maintaining compliance.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: A health-tech startup develops an AI-powered platform to analyze patient data and provide personalized treatment recommendations. The platform relies on large datasets, including sensitive health information, collected from multiple sources across the EU. While the technology promises significant advancements, it also raises critical GDPR compliance issues related to data processing, consent, and privacy safeguards.
            </code></pre>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Understanding GDPR in the Context of AI
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">The GDPR, designed to protect the privacy of individuals, presents specific challenges for AI systems that process personal data. Key provisions of the GDPR relevant to AI projects include: 1.    Lawfulness, Fairness, and Transparency: AI systems must comply with principles of fairness and transparency, ensuring individuals understand how their data is used. 2.    Purpose Limitation: Data collected for one purpose cannot be repurposed for another without explicit consent. 3.    Data Minimization: Only the data strictly necessary for the AI’s functionality should be processed. 4.    Rights of Data Subjects: Individuals retain the right to access, correct, and delete their data, as well as object to automated decision-making.
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Applying GDPR: Key Considerations for AI Projects
                    </p>
                    <ol class="row-gap-NKv2f3 flex-direction-7gclL display-BvS8W3">
                      <li>
                        <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                          <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Lawful Basis for Data Processing
                          </p>
                        </swift-html-vstack>
                      </li>
                    </ol>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Organizations must establish a lawful basis for processing personal data under Article 6 of the GDPR. Common grounds for AI projects include: * Consent: Explicit consent from data subjects is often required, particularly when processing sensitive data such as health information. * Legitimate Interests: Processing may be justified if it is necessary for the organization’s legitimate interests and does not override individuals’ rights.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: In the health-tech platform, explicit consent from patients is obtained before processing their data. However, ensuring that consent is informed and freely given remains a challenge, as patients may not fully understand how the AI processes their information.
            </code></pre>
                    <ol class="row-gap-NKv2f3 flex-direction-7gclL display-BvS8W3">
                      <li>
                        <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                          <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Data Protection by Design and Default
                          </p>
                        </swift-html-vstack>
                      </li>
                    </ol>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">AI projects must implement data protection principles from the outset, incorporating technical and organizational measures to safeguard data. Article 25 of the GDPR emphasizes: * Pseudonymization: Replacing identifying information with pseudonyms to reduce risks. * Data Encryption: Protecting data at rest and in transit to prevent unauthorized access. * Access Controls: Limiting data access to authorized personnel only.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: The health-tech startup uses pseudonymization to ensure patient identities are not directly linked to their medical data. This reduces the risk of re-identification in case of a data breach.
            </code></pre>
                    <ol class="row-gap-NKv2f3 flex-direction-7gclL display-BvS8W3">
                      <li>
                        <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                          <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Automated Decision-Making and Profiling
                          </p>
                        </swift-html-vstack>
                      </li>
                    </ol>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">AI systems that involve automated decision-making (ADM) must comply with Article 22, which grants individuals the right not to be subject to decisions based solely on automated processing unless: * Explicit consent is obtained. * The decision is necessary for a contract. * The decision is authorized by law.
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Additionally, individuals must be provided with an explanation of the logic behind the AI’s decisions and have the ability to challenge outcomes.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: The health-tech platform provides transparency by allowing patients to request explanations of the AI’s treatment recommendations. A dedicated support team addresses queries and ensures patients can contest decisions if needed.
            </code></pre>
                    <ol class="row-gap-NKv2f3 flex-direction-7gclL display-BvS8W3">
                      <li>
                        <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                          <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Data Subject Rights and AI Systems
                          </p>
                        </swift-html-vstack>
                      </li>
                    </ol>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">The GDPR grants individuals several rights that AI systems must accommodate, including: * Right to Access: Individuals can request access to their personal data. * Right to Rectification: Errors in the data must be corrected promptly. * Right to Erasure (“Right to be Forgotten”): Individuals can request deletion of their data under certain conditions. * Right to Data Portability: Data must be provided in a structured, machine-readable format if requested.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: The health-tech platform implements a user dashboard where patients can view, correct, or delete their data. The system also supports data portability by allowing patients to download their medical data in standard formats.
            </code></pre>
                    <ol class="row-gap-NKv2f3 flex-direction-7gclL display-BvS8W3">
                      <li>
                        <swift-html-vstack class="row-gap-NKv2f3 max-width-C8uWv flex-direction-7gclL display-BvS8W3 align-items-msN8p3">
                          <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Data Impact Assessments (DPIA)
                          </p>
                        </swift-html-vstack>
                      </li>
                    </ol>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">For high-risk processing activities, such as AI systems handling sensitive data, a Data Protection Impact Assessment (DPIA) is mandatory under Article 35. This involves: * Assessing the risks to data subjects. * Identifying measures to mitigate risks. * Consulting with Data Protection Authorities (DPAs) if necessary.
                    </p>
                    <pre class="border-radius-xypJ01 padding-wKavA3 overflow-x-u7yQf2 margin-bottom-NKv2f3 margin-QlFKs1 color-K2J0r1 color-0lN2z4 background-c5ixr2 background-Iaxl84"><code>Case study: The startup conducts a DPIA to evaluate the risks associated with its platform. Findings include potential biases in the AI model and the risk of re-identification, prompting additional safeguards.
            </code></pre>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Ensuring Compliance and Accountability
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">To ensure GDPR compliance in AI projects, organizations should: 1.    Integrate Privacy by Design: Build privacy considerations into the AI system from the outset. 2.    Maintain Detailed Records: Document data processing activities, including lawful basis, safeguards, and DPIA outcomes. 3.    Conduct Regular Audits: Periodically review the AI system for compliance and effectiveness of safeguards. 4.    Provide Training: Educate staff on GDPR requirements and ethical considerations in AI.
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Implications for AI Development
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">This case study highlights several lessons for AI developers and organizations: 1.    Transparency is Non-Negotiable: Clear communication with data subjects about AI processes fosters trust and reduces legal risks. 2.    Collaboration is Key: Engaging legal experts, data protection officers, and ethical advisors ensures a comprehensive approach to compliance. 3.    Proactive Risk Management: Anticipating and mitigating risks strengthens the project’s compliance and public perception.
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">Conclusion
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">The intersection of AI and GDPR presents both challenges and opportunities. By adhering to GDPR principles, organizations can build trust, enhance transparency, and unlock the full potential of AI technologies. The health-tech startup case study demonstrates that with careful planning, robust safeguards, and a commitment to accountability, AI projects can thrive within the GDPR framework.
                    </p>
                    <p class="margin-QlFKs1 padding-QlFKs1 line-height-9Qkso4">For organizations embarking on AI-driven innovation, prioritizing GDPR compliance is not merely a legal obligation but a competitive advantage in the age of data-driven decision-making.
                    </p>
                  </swift-html-vstack>
                </swift-html-markdown>
              </article>
            </div>
              </body>
            </html>
            """
        }
    }
}
